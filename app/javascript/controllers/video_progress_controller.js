import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    // Track last update time to throttle progress updates
    this.lastUpdateTime = 0
    this.updateInterval = 30000 // 30 seconds

    // Brightcove player initialization happens automatically via the script tag
    // We just need to wait for the 'ready' event
    this.element.addEventListener('ready', () => {
      this.initializePlayer()
    })
  }

  initializePlayer() {
    // Get the Brightcove player instance using videojs global
    this.player = videojs(this.element.id)
    
    if (!this.player) {
      console.error('Could not get Brightcove player instance')
      return
    }

    this.player.on("timeupdate", () => {
      const now = Date.now()
      if (now - this.lastUpdateTime >= this.updateInterval) {
        const current_time = Math.floor(this.player.currentTime())
        const duration = this.player.duration()
        if (duration && !isNaN(duration) && duration > 0) {
          const percent = Math.floor((current_time / duration) * 100)
          this.sendProgress(current_time, percent)
          this.lastUpdateTime = now
        }
      }
    })

    this.player.on("ended", () => {
      const duration = this.player.duration()
      if (duration && !isNaN(duration) && duration > 0) {
        this.sendFinal(Math.floor(duration), 100)
      }
    })
  }

  sendProgress(current_time, percent) {
    fetch(this.urlValue, {
      method: "PATCH",
      headers: this.headers(),
      body: JSON.stringify({ current_time, duration: Math.floor(this.player.duration()), percent })
    })
  }

  sendFinal(current_time, percent) {
    fetch(this.urlValue, {
      method: "PATCH",
      headers: this.headers(),
      body: JSON.stringify({ current_time, duration: Math.floor(this.player.duration()), percent, completed: true })
    })
  }

  headers() {
    return {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
    }
  }
}
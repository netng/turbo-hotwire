import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {

    activeClass = ["navbar--active"]

    scroll() {
        if (window.scrollY >= 40) {
            this.element.classList.add(this.activeClass);
            console.log(this);
        } else {
            this.element.classList.remove(this.activeClass);
        }
    }
}

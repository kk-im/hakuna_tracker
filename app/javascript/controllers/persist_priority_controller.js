import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello from persist priority controller")
  }
}

// the connection is working in the all projects page

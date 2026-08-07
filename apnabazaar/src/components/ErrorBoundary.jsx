import { Component } from "react";

class ErrorBoundary extends Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  componentDidCatch(error, info) {
    console.log("kuch toh gadbad hai:", error, info);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ padding: "40px", textAlign: "center" }}>
          <h2>Arre yaar, kuch to toot gaya </h2>
          <p>Page refresh kar lo, chal jayega shayad</p>
        </div>
      );
    }
    return this.props.children;
  }
}

export default ErrorBoundary;
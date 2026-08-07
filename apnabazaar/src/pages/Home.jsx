import { Link } from "react-router-dom";

function Home() {
  return (
    <div className="home">
      <h1>Sab kuch milega, bas dhoond lo </h1>
      <p>COD available, kyunki trust issues sabko hote hai</p>
      <Link to="/products"><button>Shopping shuru karo</button></Link>
    </div>
  );
}

export default Home;
import { memo } from "react";
import { Link } from "react-router-dom";

function ProductCard({ product }) {
  return (
    <div className="card">
      <h3>{product.name}</h3>
      <p>{product.desc}</p>
      <p className="price">Rs.{product.price}</p>
      <Link to={`/products/${product.id}`}>Dekho zara</Link>
    </div>
  );
}

export default memo(ProductCard);
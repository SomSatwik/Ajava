import { useParams } from "react-router-dom";
import { useState } from "react";
import products from "../data/products";
import { useCart } from "../context/CartContext";
import useWishlistStore from "../store/wishlistStore";

function ProductDetail() {
  const { id } = useParams();
  const product = products.find((p) => p.id === Number(id));
  const { addToCart } = useCart();
  const addToWishlist = useWishlistStore((s) => s.addToWishlist);
  const [country, setCountry] = useState(null);

  const checkDelivery = async () => {
    const res = await fetch("https://countries.trevorblades.com/", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        query: `{ country(code: "IN") { name capital } }`,
      }),
    });
    const json = await res.json();
    setCountry(json.data.country);
  };

  if (!product) return <p>Ye product exist hi nahi karta bhai</p>;

  return (
    <div className="detail">
      <h1>{product.name}</h1>
      <p>{product.desc}</p>
      <p className="price">₹{product.price}</p>
      <button onClick={() => addToCart(product)}>Cart mein daalo</button>
      <button onClick={() => addToWishlist(product)}>Wishlist </button>
      <button onClick={checkDelivery}>Delivery check karo (GraphQL)</button>
      {country && <p>Delivers to {country.name}, HQ near {country.capital} </p>}
    </div>
  );
}

export default ProductDetail;
import { useState, useMemo } from "react";
import products from "../data/products";
import ProductCard from "../components/ProductCard";
import useFetch from "../hooks/useFetch";

function Products() {
  const [search, setSearch] = useState("");
  const { data: trending, loading } = useFetch("https://fakestoreapi.com/products?limit=3");

  const filtered = useMemo(() => {
    return products.filter((p) =>
      p.name.toLowerCase().includes(search.toLowerCase())
    );
  }, [search]);

  return (
    <div>
      <input
        placeholder="Kya dhoond rahe ho?"
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      <h3>Trending (from real API, thoda flex maar rahe hai)</h3>
      {loading ? <p>Loading...</p> : (
        <div className="grid">
          {trending.map((t) => (
            <div className="card" key={t.id}>
              <p>{t.title.slice(0, 20)}...</p>
              <p>₹{Math.round(t.price * 80)}</p>
            </div>
          ))}
        </div>
      )}

      <h3>Sabhi Products</h3>
      <div className="grid">
        {filtered.map((p) => <ProductCard key={p.id} product={p} />)}
      </div>
    </div>
  );
}

export default Products;
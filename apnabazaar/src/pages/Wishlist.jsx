import useWishlistStore from "../store/wishlistStore";

function Wishlist() {
  const wishlist = useWishlistStore((s) => s.wishlist);
  const removeFromWishlist = useWishlistStore((s) => s.removeFromWishlist);

  return (
    <div>
      <h2>Wishlist </h2>
      {wishlist.length === 0 && <p>Kuch bhi like nahi kiya abhi tak</p>}
      {wishlist.map((item, i) => (
        <div key={i} className="cart-item">
          <p>{item.name}</p>
          <button onClick={() => removeFromWishlist(item.id)}>Hatao</button>
        </div>
      ))}
    </div>
  );
}

export default Wishlist;
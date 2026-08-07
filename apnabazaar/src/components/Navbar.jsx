import { Link } from "react-router-dom";
import { useCart } from "../context/CartContext";
import useWishlistStore from "../store/wishlistStore";
import { useDispatch, useSelector } from "react-redux";
import { toggleTheme } from "../redux/themeSlice";

function Navbar() {
  const { cart } = useCart();
  const wishlist = useWishlistStore((s) => s.wishlist);
  const dispatch = useDispatch();
  const mode = useSelector((state) => state.theme.mode);

  return (
    <nav className="navbar">
      <h2>ApnaBazaar </h2>
      <div className="nav-links">
        <Link to="/">Home</Link>
        <Link to="/products">Products</Link>
        <Link to="/cart">Cart ({cart.length})</Link>
        <Link to="/wishlist">Wishlist ({wishlist.length})</Link>
        <Link to="/about">About</Link>
        <button onClick={() => dispatch(toggleTheme())}>
          {mode === "light" ? " Dark" : " Light"}
        </button>
      </div>
    </nav>
  );
}

export default Navbar;
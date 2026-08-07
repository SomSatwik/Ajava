import { create } from "zustand";

const useWishlistStore = create((set) => ({
  wishlist: [],
  addToWishlist: (product) =>
    set((state) => ({ wishlist: [...state.wishlist, product] })),
  removeFromWishlist: (id) =>
    set((state) => ({ wishlist: state.wishlist.filter((p) => p.id !== id) })),
}));

export default useWishlistStore;
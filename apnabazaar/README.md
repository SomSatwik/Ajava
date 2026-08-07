# ApnaBazaar

ApnaBazaar is a React-based e-commerce web application built as a frontend project. It provides the basic functionality of an online shopping platform while demonstrating concepts such as routing, state management, API integration, reusable components, and React performance optimization.

## Features

- Product listing
- Product search
- Product details
- Shopping cart
- Wishlist
- Light and dark theme
- REST API integration
- GraphQL API integration
- Dynamic routing
- Lazy loading
- Error handling with an error boundary
- Responsive product layout

## Technologies Used

- React
- Vite
- JavaScript
- CSS
- React Router
- Context API
- Zustand
- Redux Toolkit
- REST API
- GraphQL

## Project Structure

```text
apnabazaar/
├── src/
│   ├── components/
│   │   ├── ErrorBoundary.jsx
│   │   ├── Navbar.jsx
│   │   └── ProductCard.jsx
│   │
│   ├── context/
│   │   └── CartContext.jsx
│   │
│   ├── data/
│   │   └── products.js
│   │
│   ├── hooks/
│   │   └── useFetch.js
│   │
│   ├── pages/
│   │   ├── About.jsx
│   │   ├── Cart.jsx
│   │   ├── Home.jsx
│   │   ├── ProductDetail.jsx
│   │   ├── Products.jsx
│   │   └── Wishlist.jsx
│   │
│   ├── redux/
│   │   ├── store.js
│   │   └── themeSlice.js
│   │
│   ├── store/
│   │   └── wishlistStore.js
│   │
│   ├── App.jsx
│   ├── index.css
│   └── main.jsx
│
├── package.json
└── README.md

ApnaBazaar

ApnaBazaar is a simple e-commerce web application built with React. Theproject focuses on the core features of an online shopping experiencewhile also demonstrating different approaches to routing, statemanagement, API integration, and basic React performance techniques.

Features

Home page with navigation to the shopping section

Product listing with search functionality

Individual product detail pages

Shopping cart with item removal and total calculation

Wishlist functionality

Light and dark theme toggle

REST API integration for a trending products section

GraphQL integration for a basic country/delivery check

Dynamic routing for product pages

Lazy loading for application pages

Error boundary for handling unexpected React errors

Responsive product grid

Technologies Used

React

Vite

React Router

Context API

Zustand

Redux Toolkit

JavaScript

CSS

REST API

GraphQL

Project Structure

src/
├── components/
│   ├── ErrorBoundary.jsx
│   ├── Navbar.jsx
│   └── ProductCard.jsx
├── context/
│   └── CartContext.jsx
├── data/
│   └── products.js
├── hooks/
│   └── useFetch.js
├── pages/
│   ├── About.jsx
│   ├── Cart.jsx
│   ├── Home.jsx
│   ├── ProductDetail.jsx
│   ├── Products.jsx
│   └── Wishlist.jsx
├── redux/
│   ├── store.js
│   └── themeSlice.js
├── store/
│   └── wishlistStore.js
├── App.jsx
├── index.css
└── main.jsx

State Management

The project uses three different state management approaches fordifferent parts of the application:

Context API is used for the shopping cart.

Zustand is used to manage the wishlist.

Redux Toolkit is used for the theme preference.

This keeps the different types of application state separated and makeseach approach easy to maintain.

API Integration

The products page uses the Fake Store API to display a small trendingproducts section.

The product detail page also includes a GraphQL request to retrievecountry information.

Getting Started

Prerequisites

Make sure Node.js and npm are installed on your system.

Installation

Clone the repository and move into the project directory:

git clone <repository-url>
cd "ecommerce website"

Install the dependencies:

npm install

Start the development server:

npm run dev

The application will be available at the local address shown in theterminal, normally:

http://localhost:5173

Available Routes

Route             Description

/               Home page/products       Product listing and search/products/:id   Product details/cart           Shopping cart/wishlist       Wishlist/about          About page

Notes

The product catalogue is currently stored locally insrc/data/products.js. The external APIs are used for demonstration anddo not represent a production backend.

The project is intended as a front-end e-commerce application and can beextended later with features such as user authentication, a real productdatabase, payments, order management, and a backend service.

Author

SomSatwik

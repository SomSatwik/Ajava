import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <div style={{ display: 'flex', gap: '15px', padding: '10px 0', borderBottom: '1px solid #ccc', marginBottom: '20px' }}>
      <Link to="/">Home</Link>
      <Link to="/courses">Courses</Link>
      <Link to="/about">About</Link>
    </div>
  );
}

export default Navbar;

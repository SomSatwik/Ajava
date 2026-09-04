import { Link } from 'react-router-dom';

function Courses() {
  const courses = [
    { id: '1', name: 'Java Programming' },
    { id: '2', name: 'Web Development' },
    { id: '3', name: 'Database Systems' }
  ];

  return (
    <div>
      <h2>Courses</h2>
      <ul>
        {courses.map((c) => (
          <li key={c.id} style={{ margin: '10px 0' }}>
            <span>{c.name} - </span>
            <Link to={`/course/${c.id}`}>View Details</Link>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Courses;

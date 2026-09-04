import { useContext } from 'react';
import { StudentContext } from '../context/StudentContext';

function Home() {
  const { student } = useContext(StudentContext);

  return (
    <div>
      <h2>Home</h2>
      <p>Welcome to Student Course Management</p>
      <div style={{ marginTop: '20px', border: '1px solid #ccc', padding: '10px' }}>
        <h3>Student Information</h3>
        <p>Name: {student.name}</p>
        <p>Roll No: {student.rollNo}</p>
        <p>College: {student.college}</p>
      </div>
    </div>
  );
}

export default Home;

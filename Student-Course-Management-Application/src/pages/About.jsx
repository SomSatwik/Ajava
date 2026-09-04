import { useContext } from 'react';
import { StudentContext } from '../context/StudentContext';

function About() {
  const { student } = useContext(StudentContext);

  return (
    <div>
      <h2>About Us</h2>
      <p>This is a student course management portal.</p>
      <p>Logged in as: {student.name} ({student.college})</p>
    </div>
  );
}

export default About;

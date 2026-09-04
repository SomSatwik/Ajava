import { useParams, Link } from 'react-router-dom';
import { useContext } from 'react';
import { StudentContext } from '../context/StudentContext';

function CourseDetail() {
  const { id } = useParams();
  const { student } = useContext(StudentContext);

  const courseData = {
    '1': { name: 'Java Programming', duration: '6 Months', fee: '5000' },
    '2': { name: 'Web Development', duration: '4 Months', fee: '4000' },
    '3': { name: 'Database Systems', duration: '3 Months', fee: '3000' }
  };

  const course = courseData[id];

  if (!course) {
    return (
      <div>
        <p>Course not found</p>
        <Link to="/courses">Back to Courses</Link>
      </div>
    );
  }

  return (
    <div>
      <h2>Course Details</h2>
      <p>Course ID: {id}</p>
      <p>Name: {course.name}</p>
      <p>Duration: {course.duration}</p>
      <p>Fee: Rs. {course.fee}</p>
      <p>Student Name: {student.name}</p>
      <br />
      <Link to="/courses">Back to Courses</Link>
    </div>
  );
}

export default CourseDetail;

import { useState } from 'react';
import './App.css';

function App() {
  const [form, setForm] = useState({ name: '', email: '', course: '' });
  const [submitted, setSubmitted] = useState(null);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  function handleSubmit(e) {
    e.preventDefault();
    setSubmitted(form);
    setForm({ name: '', email: '', course: '' });
  }

  return (
    <div className="container">
      <h2>Student Registration</h2>
      <form onSubmit={handleSubmit}>
        <label>Name</label>
        <input name="name" value={form.name} onChange={handleChange} required />

        <label>Email</label>
        <input name="email" type="email" value={form.email} onChange={handleChange} required />

        <label>Course</label>
        <input name="course" value={form.course} onChange={handleChange} required />

        <button type="submit">Submit</button>
      </form>

      {submitted && (
        <div className="details">
          <h3>Submitted Details</h3>
          <p>Name: {submitted.name}</p>
          <p>Email: {submitted.email}</p>
          <p>Course: {submitted.course}</p>
        </div>
      )}
    </div>
  );
}

export default App;

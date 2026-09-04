import { createContext, useState } from 'react';

export const StudentContext = createContext();

export function StudentProvider({ children }) {
  const [student, setStudent] = useState({
    name: 'Satwik Som',
    rollNo: '210101',
    college: 'GIET'
  });

  return (
    <StudentContext.Provider value={{ student, setStudent }}>
      {children}
    </StudentContext.Provider>
  );
}

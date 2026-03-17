package com.bibliox.util;

import com.bibliox.dao.BookDAO;
import com.bibliox.dao.UserDAO;
import com.bibliox.model.Book;
import com.bibliox.model.Role;
import com.bibliox.model.User;

public class DataSeeder {

    public static void seed() {
        UserDAO userDAO = new UserDAO();
        BookDAO bookDAO = new BookDAO();

        // Seed users if none exist
        if (userDAO.countAll() == 0) {
            User superAdmin = new User();
            superAdmin.setName("Som Satwik");
            superAdmin.setEmail("superadmin@bibliox.com");
            superAdmin.setPassword(PasswordUtil.hash("admin123"));
            superAdmin.setRole(Role.SUPER_ADMIN);
            userDAO.save(superAdmin);

            User admin = new User();
            admin.setName("Ritesh Kumar");
            admin.setEmail("admin@bibliox.com");
            admin.setPassword(PasswordUtil.hash("admin123"));
            admin.setRole(Role.ADMIN);
            userDAO.save(admin);

            User student = new User();
            student.setName("Ananya Patra");
            student.setEmail("student@bibliox.com");
            student.setPassword(PasswordUtil.hash("student123"));
            student.setRole(Role.USER);
            userDAO.save(student);

            System.out.println("[BiblioX] Default users seeded.");
        }

        // Seed books if none exist
        if (bookDAO.countAll() == 0) {
            String[][] books = {
                {"Clean Code", "Robert C. Martin", "978-0132350884", "Engineering", "5"},
                {"Intro to Algorithms", "Cormen et al.", "978-0262033848", "CS Theory", "3"},
                {"Hibernate in Action", "Bauer & King", "978-1932394887", "Java/ORM", "4"},
                {"OS Concepts", "Silberschatz", "978-1119800361", "Systems", "6"},
                {"Domain-Driven Design", "Eric Evans", "978-0321125217", "Architecture", "2"},
                {"The Pragmatic Programmer", "Hunt & Thomas", "978-0201616224", "Engineering", "4"},
                {"Design Patterns", "Gang of Four", "978-0201633610", "Architecture", "3"},
                {"You Don't Know JS", "Kyle Simpson", "978-1491924464", "Web Dev", "5"}
            };

            for (String[] b : books) {
                Book book = new Book();
                book.setTitle(b[0]);
                book.setAuthor(b[1]);
                book.setIsbn(b[2]);
                book.setGenre(b[3]);
                book.setTotalCopies(Integer.parseInt(b[4]));
                book.setAvailableCopies(Integer.parseInt(b[4]));
                bookDAO.save(book);
            }

            System.out.println("[BiblioX] Default books seeded.");
        }
    }
}

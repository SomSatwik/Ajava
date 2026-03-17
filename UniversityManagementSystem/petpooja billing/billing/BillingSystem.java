package com.petpooja.billing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BillingSystem {
    public BillingSystem() {
        DB.init();
        ensureBasicFood();
    }

    private void ensureBasicFood() {
        try (Connection conn = DB.getConnection(); Statement st = conn.createStatement()) {
            ResultSet rs = st.executeQuery("SELECT COUNT(*) as c FROM products");
            if (rs.next() && rs.getInt("c") == 0) {
                addProduct("Plain Rice", "Basic Food", 30.0);
                addProduct("Bread", "Basic Food", 10.0);
                addProduct("Boiled Egg", "Basic Food", 15.0);
            }
        } catch (SQLException e) {
            System.err.println("ensureBasicFood error: " + e.getMessage());
        }
    }

    public void addProduct(String name, String category, double price) {
        String sql = "INSERT INTO products(name,category,price) VALUES(?,?,?)";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setDouble(3, price);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("addProduct error: " + e.getMessage());
        }
    }

    public List<Product> listProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id,name,category,price FROM products ORDER BY id";
        try (Connection conn = DB.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getString("category"), rs.getDouble("price")));
            }
        } catch (SQLException e) {
            System.err.println("listProducts error: " + e.getMessage());
        }
        return list;
    }

    public double createBill(List<Item> items) {
        double total = 0.0;
        System.out.println("\n----- Bill -----");
        for (Item it : items) {
            Product p = findProductById(it.productId);
            if (p != null) {
                double line = p.getPrice() * it.qty;
                System.out.println(p.getName() + " x" + it.qty + " = " + String.format("%.2f", line));
                total += line;
            }
        }
        System.out.println("Total: " + String.format("%.2f", total));
        System.out.println("----------------\n");
        return total;
    }

    public Product findProductById(int id) {
        String sql = "SELECT id,name,category,price FROM products WHERE id=?";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("name"), rs.getString("category"), rs.getDouble("price"));
            }
        } catch (SQLException e) {
            System.err.println("findProductById error: " + e.getMessage());
        }
        return null;
    }

    public static class Item {
        public final int productId;
        public final int qty;
        public Item(int productId, int qty) { this.productId = productId; this.qty = qty; }
    }
}

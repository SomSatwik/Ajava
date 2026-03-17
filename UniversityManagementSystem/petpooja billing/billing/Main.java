package com.petpooja.billing;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        BillingSystem system = new BillingSystem();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("Pet Pooja Billing System");
            System.out.println("1) List products");
            System.out.println("2) Add product");
            System.out.println("3) Create bill");
            System.out.println("4) Exit");
            System.out.print("Choose: ");
            String choice = scanner.nextLine().trim();
            switch (choice) {
                case "1":
                    List<Product> products = system.listProducts();
                    products.forEach(p -> System.out.println(p.toString()));
                    break;
                case "2":
                    System.out.print("Name: ");
                    String name = scanner.nextLine().trim();
                    System.out.print("Category: ");
                    String cat = scanner.nextLine().trim();
                    System.out.print("Price: ");
                    double price = Double.parseDouble(scanner.nextLine().trim());
                    system.addProduct(name, cat.isEmpty() ? "Basic Food" : cat, price);
                    System.out.println("Product added.");
                    break;
                case "3":
                    List<BillingSystem.Item> items = new ArrayList<>();
                    while (true) {
                        System.out.print("Enter product id (or blank to finish): ");
                        String idStr = scanner.nextLine().trim();
                        if (idStr.isEmpty()) break;
                        int id = Integer.parseInt(idStr);
                        System.out.print("Quantity: ");
                        int q = Integer.parseInt(scanner.nextLine().trim());
                        items.add(new BillingSystem.Item(id, q));
                    }
                    if (!items.isEmpty()) system.createBill(items);
                    break;
                case "4":
                    System.out.println("Bye");
                    System.exit(0);
                    return;
                default:
                    System.out.println("Invalid choice");
            }
            System.out.println();
        }
    }
}

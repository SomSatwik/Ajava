# JDBC Transaction Error Explanation

## The Main Error (The "Bug")
The specific logic error in the original code is **swallowing the exception** inside the transaction block.

### In Original Code:
```java
} catch(Exception e) {
    connection.rollback();
    System.out.println("Transaction Failed");
}
```
**Why it's bad:** When an error occurs (like a constraint violation, insufficient balance, or missing table), the code catches the exception `e`, rolls back the transaction, and prints "Transaction Failed". **However, it never prints what `e` actually was.**
As a result, you have no idea *why* it failed. It makes debugging impossible.

### The Fix:
You should always print the exception stack trace or message before rolling back.

```java
} catch(Exception e) {
    e.printStackTrace(); // <--- CRITICAL FIX
    connection.rollback();
    System.out.println("Transaction Failed");
}
```

## Secondary Issues (Best Practices)

1. **Resource Leaks**: 
   - The original code never closes the `Connection` or `PreparedStatement` objects. This causes memory leaks and database connection exhaustion.
   - **Fix**: Use a `finally` block to close the connection, or use "try-with-resources".

2. **Typos**:
   - `System.out.println("Transaction Successfull");` -> "Successful" has one 'l'.

3. **Class Naming**:
   - `public class transaction` -> Java classes should start with an Uppercase letter (PascalCase), e.g., `Transaction`.

4. **Rollback Safety**:
   - The `connection.rollback()` method itself can throw an `SQLException`. It should technically be wrapped in a try-catch to avoid crashing inside the catch block (though the outer catch handles it, it's safer to handle it explicitly).

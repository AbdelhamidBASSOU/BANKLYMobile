package bankly.resource;

import bankly.entity.Transaction;
import bankly.service.TransactionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/transaction")
public class TransactionResource {
    private final TransactionService transactionService;

    @GetMapping("/{id}")
    public Transaction getTransaction(@PathVariable Long id) {
        return transactionService.getTransaction(id);
    }

    @PutMapping("/{id}")
    public Transaction updateTransaction(@PathVariable Long id, @RequestBody Transaction transaction) {
        return transactionService.updateTransaction(id, transaction);
    }

    @DeleteMapping("/{id}")
    public void deleteTransaction(@PathVariable Long id) {
        transactionService.deleteTransaction(id);
    }

    @PostMapping("/debit")
    public void debit(@RequestParam("walletId") Long walletId, @RequestParam("amount") Double amount) {
        transactionService.debit(walletId, amount);
    }

    @PostMapping("/credit")
    public void credit(@RequestParam("walletId") Long walletId, @RequestParam("amount") Double amount) {
        transactionService.credit(walletId, amount);
    }
}

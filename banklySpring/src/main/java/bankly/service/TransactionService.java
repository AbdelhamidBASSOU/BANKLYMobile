package bankly.service;

import bankly.entity.Transaction;
import bankly.repository.TransactionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
public interface TransactionService {
    Transaction getTransaction(Long id);
    Transaction updateTransaction(Long id, Transaction transaction);
    void deleteTransaction(Long id);
    void debit(Long walletId, Double amount);
    void credit(Long walletId, Double amount);
}

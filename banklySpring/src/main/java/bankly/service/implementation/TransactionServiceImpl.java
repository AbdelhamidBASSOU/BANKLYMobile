package bankly.service.implementation;

import bankly.entity.Transaction;
import bankly.entity.Type;
import bankly.entity.Wallet;
import bankly.repository.TransactionRepository;
import bankly.repository.WalletRepository;
import bankly.service.TransactionService;
import bankly.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    WalletRepository walletRepository;
    private final TransactionRepository transactionRepository;
    private final WalletService walletService;
    public Transaction getTransaction(Long id) {
        return transactionRepository.findById(id).orElse(null); }

    public Transaction updateTransaction(Long id, Transaction transaction) {
        Transaction existingTransaction = getTransaction(id);
        existingTransaction.setAmount(transaction.getAmount());
        existingTransaction.setType(transaction.getType());
        existingTransaction.setDate(transaction.getDate());
        return transactionRepository.save(existingTransaction);
    }
    public void deleteTransaction(Long id) {
        transactionRepository.deleteById(id);
    }

    public void debit(Long walletId, Double amount) {
        Wallet wallet = walletService.getOne(walletId);
        double currentBalance = wallet.getBalance();
        if (currentBalance >= amount) {
            Double newBalance = currentBalance - amount;
            Transaction transaction = new Transaction();
            transaction.setAmount(newBalance);
            transaction.setType(Type.WITHDRAWAL);
            wallet.setBalance(newBalance);
            transactionRepository.save(transaction);
            walletRepository.save(wallet);
        } else {
            throw new IllegalStateException("Votre solde est insuffisant");
        }
    }

    public void credit(Long walletId, Double amount) {
        Wallet wallet = walletService.getOne(walletId);
        double currentBalance = wallet.getBalance();
        Double newBalance = currentBalance - amount;
        Transaction transaction = new Transaction();
        transaction.setAmount(newBalance);
        transaction.setType(Type.DEPOSIT);
        wallet.setBalance(newBalance);
        transactionRepository.save(transaction);
        walletRepository.save(wallet);
    }

}

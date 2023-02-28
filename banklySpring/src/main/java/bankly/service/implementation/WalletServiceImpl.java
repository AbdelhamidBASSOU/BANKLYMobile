package bankly.service.implementation;

import bankly.entity.Currency;
import bankly.entity.Wallet;
import bankly.repository.WalletRepository;
import bankly.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WalletServiceImpl implements WalletService {


    private final WalletRepository walletRepository;

    public List<Wallet> getAll() {
        return walletRepository.findAll();
    }

    public Wallet updateWallet(Long id, Wallet wallet) {
        Wallet walletWithId= walletRepository.findById(id).orElse(null);
        if(walletWithId != null ){
            walletWithId.setBalance(wallet.getBalance());
            walletWithId.setCurrency(Currency.USD);
            walletWithId.setTransactionHistory(wallet.getTransactionHistory());
            return walletWithId;
        }else{
            throw new IllegalStateException("wallet cannot be found");
        }
    }

    public Wallet addWallet(Wallet wallet) {
        wallet.setCurrency(Currency.USD);
        return walletRepository.save(wallet);
    }


    public Wallet getOne(Long walletId){
        return walletRepository.findById(walletId).orElseThrow(() -> new IllegalArgumentException("Invalid wallet ID"));
    }


    public double checkBalance(Long walletId) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid wallet ID"));
        return wallet.getBalance();
    }
}
package bankly.resource;

import bankly.entity.Wallet;
import bankly.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


    @RestController
    @RequiredArgsConstructor
    @RequestMapping("/api/wallet")
    public class WalletResource {
        private final WalletService walletService;

        @PostMapping("/add")
        public Wallet addWallet(@RequestBody Wallet wallet) {
            return walletService.addWallet(wallet);
        }

        @PutMapping("/{wallet_id}")
        public Wallet updateWallet(@PathVariable Long wallet_id, @RequestBody Wallet wallet) {
            return walletService.updateWallet(wallet_id, wallet);
        }

        @GetMapping("/Wallets")
        public List<Wallet> getWallet() {
            return walletService.getAll();
        }

        @GetMapping("/Wallet/{walletId}")
        public Wallet getOne(@PathVariable Long walletId) {
            return walletService.getOne(walletId);
        }

        @GetMapping("/balance/{walletId}")
        public ResponseEntity<Double> checkBalance(@PathVariable Long walletId) {
            Double balance = walletService.checkBalance(walletId);
            return ResponseEntity.ok(balance);
        }

        }


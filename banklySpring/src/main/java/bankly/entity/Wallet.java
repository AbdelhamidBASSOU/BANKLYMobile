package bankly.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Wallet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long  id;

    private double balance;

    @Enumerated
    private Currency currency;

    private String transactionHistory;

    @OneToMany(mappedBy = "wallet")
    private List<Transaction> transactions;
}

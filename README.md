**Membership Registry – Clarity Smart Contract**

A lightweight on-chain membership management system built for the Stacks blockchain.
This contract enables decentralized applications to register, remove, and verify members securely using Clarity smart contract logic.

---

**Features**

**Owner-controlled membership management**
**Add or remove members** with secure authorization checks
**Verify membership status** through read-only functions
**Minimal, efficient, and extendable architecture**
Suitable for **DAOs**, **communities**, **token-gated systems**, and **access control modules**

---

**Contract Overview**

**Data Storage**

| Name             | Type     | Description                                       |
| ---------------- | -------- | ------------------------------------------------- |
| `members`        | Map      | Stores a boolean status for registered principals |
| `contract-owner` | Constant | Defines the owner who controls membership changes |

**Public Functions**

| Function        | Description                                        |
| --------------- | -------------------------------------------------- |
| `add-member`    | Registers a new principal as a member (owner-only) |
| `remove-member` | Removes a principal from membership (owner-only)   |

**Read-Only Functions**

| Function     | Description                                   |
| ------------ | --------------------------------------------- |
| `is-member?` | Returns `true` if the principal is registered |
| `get-owner`  | Returns the contract owner                    |

---

**Usage**

**Add a Member**

```clarity
(contract-call? .membership-registry add-member tx-sender)
```

**Remove a Member**

```clarity
(contract-call? .membership-registry remove-member tx-sender)
```

**Check Membership**

```clarity
(contract-call? .membership-registry is-member? tx-sender)
```

---

**Integration Examples**

This contract can be used to:

* Gate access to certain contract functions
* Register DAO or community participants
* Build tokenless access control modules
* Track verified users, voters, or contributors

---

**Testing (Clarinet)**

Run tests:

```bash
clarinet test
```

Recommended test cases:

* Owner can add/remove members
* Non-owner cannot modify membership
* `is-member?` returns correct values
* Membership removal correctly updates the registry

---

**Suggested Project Structure**

```
/contracts
   └── membership-registry.clar
/tests
   └── membership-registry_test.ts
README.md
Clarinet.toml
```

---

**Security Notes**

* Only the **contract owner** can modify membership.
* The contract avoids unnecessary data writes to reduce fees.
* Designed with clarity, simplicity, and auditability in mind.

---

**Contributing**

Contributions are welcome!
Feel free to submit pull requests, issues, or feature suggestions.

---

**License**

Licensed under the **MIT License**.

---


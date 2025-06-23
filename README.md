# Sudoku in 8088 Assembly (Text Mode)

A feature-rich Sudoku game built entirely in 8088 Assembly, running in text mode. Designed for performance and challenge, this project demonstrates the power of low-level programming with interactive gameplay.

---

## 🧩 Features

- ✅ **Difficulty Levels**: Easy, Medium, and Hard modes
- 🔊 **Sound Effects**: Feedback sounds for correct/incorrect moves
- ❌ **Mistake Counter**: Tracks the number of wrong entries
- ↩️ **Undo Function**: Press `U` to undo the last move
- 🧭 **Scrolling Support**: Navigate across larger puzzles easily
- 🃏 **Card-Based Input**: Select and place numbers through a card-like system
- ⏱️ **Timer**: See how long you take to solve the puzzle
- 📝 **Notes Feature**: Press `N` to toggle and write pencil notes in cells

---

## 🎮 Controls

| Key           | Function               |
|---------------|------------------------|
| `Arrow Keys`  | Navigate cells         |
| `1`–`9`       | Input number into cell |
| `U`           | Undo last move         |
| `N`           | Toggle notes mode      |
| `Esc`         | Exit the game          |

---

## 📽️ Demo

Watch the demo here: [Google Drive Link](https://drive.google.com/file/d/1ZhWkrp36hJ8WaZf_8X84h4J_o4A3xM2Z/view?usp=drive_link)

---

## 🛠 How to Build and Run

### Requirements:
- [NASM Assembler](https://www.nasm.us/)
- DOSBox (for running in modern Windows environments)

### Compile with NASM:
```bash
nasm -f bin sudoku.asm -o sudoku.com

# Hangman

A command-line Hangman game in Ruby with **save and load**, from the [The Odin Project](https://www.theodinproject.com/) Ruby curriculum.

## How to play

- The computer picks a random 5–12 letter word from a dictionary
- Guess one letter or the whole word each round. You have 10 rounds.
- Type `save` at any point to save your progress, or `load` to resume a saved game
- Correct and incorrect guesses are shown in color

## What I practiced

- File I/O: reading the dictionary
- **Serialization**: game state is saved to and restored from YAML files in `saved/`
- Separating game logic (`Hangman`) from persistence (`HangmanState`)

## Run

```bash
cd lib
ruby main.rb
```

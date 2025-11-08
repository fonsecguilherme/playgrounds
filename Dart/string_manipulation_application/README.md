# Exercícios de Manipulação de Strings em Dart

Este documento contém uma coleção de exercícios práticos para aprimorar suas habilidades em **manipulação de strings**, organizados por nível de dificuldade.

---

## 🟢 Nível Iniciante

### 1. Contar vogais 🟢
Conte quantas vogais (`a, e, i, o, u`) aparecem em uma string (case-insensitive).  
**Exemplo:** `"Olá Mundo"` → `3`  
**Dica:** normalize para minúsculas e use um `Set` de vogais.  
**Função sugerida:** `int countVowels(String s)`

---

### 2. Reverter palavras 🟢
Dada uma frase, reverta cada palavra mantendo a ordem das palavras.  
**Exemplo:** `"eu amo dart"` → `"ue oma trad"`  
**Dica:** use `split`, `map` e `join`.  
**Função sugerida:** `String reverseWords(String s)`

---

### 3. Palíndromo (somente letras) 🟡
Verifique se uma string é palíndroma considerando apenas letras e ignorando maiúsculas/minúsculas.  
**Exemplo:** `"A man, a plan, a canal: Panama!"` → `true`  
**Dica:** filtre letras e compare com o reverso.  
**Função sugerida:** `bool isPalindrome(String s)`

---

### 4. Capitalizar frase 🟢
Transforme `"olá mundo. isso é dart!"` em `"Olá Mundo. Isso É Dart!"`.  
**Dica:** capitalize a primeira letra de cada palavra.  
**Função sugerida:** `String capitalizeWords(String s)`

---

### 5. Contar ocorrências de substring
Conte quantas vezes uma substring aparece (inclusive sobreposições).  
**Exemplo:** `"aaaa"`, `"aa"` → `3`  
**Função sugerida:** `int countSubstring(String s, String sub)`

---

## 🟡 Nível Intermediário

### 6. Remover duplicatas de caracteres mantendo ordem
**Exemplo:** `"abracadabra"` → `"abrcd"`  
**Função sugerida:** `String removeDuplicates(String s)`

---

### 7. Compressão simples (Run-Length Encoding)
**Exemplo:** `"aaabbc"` → `"a3b2c1"`  
**Função sugerida:** `String rleCompress(String s)`

---

### 8. Agrupar anagramas
**Exemplo:** `["ate","eat","tea","tan","nat"]` → `[["ate","eat","tea"],["tan","nat"]]`  
**Função sugerida:** `List<List<String>> groupAnagrams(List<String> words)`

---

### 9. Extrair números de uma string
**Exemplo:** `"ID: 42, price: 3.50, code: 007"` → `["42", "3.50", "007"]`  
**Função sugerida:** `List<String> extractNumbers(String s)`

---

### 10. Substituir palavras por sinônimos (map)
**Exemplo:** `"Bom dia, meu velho amigo"` → `"Ótimo dia, meu antigo amigo"`  
**Função sugerida:** `String replaceWords(String s, Map<String,String> map)`

---

## 🔵 Nível Avançado

### 11. Parser simples CSV
**Exemplo:** `"a,\"b,bb\",c"` → `["a", "b,bb", "c"]`  
**Função sugerida:** `List<String> parseCsvLine(String line)`

---

### 12. Normalização Unicode
Normalize uma string para forma NFC.  
**Função sugerida:** `String normalizeNfc(String s)`

---

### 13. Substring mais longa sem caracteres repetidos
**Exemplo:** `"abcabcbb"` → `3`  
**Função sugerida:** `int lengthOfLongestUniqueSubstring(String s)`

---

### 14. Template engine mínima
**Exemplo:** `"Olá {{name}}!"` + `{name: "Guilherme"}` → `"Olá Guilherme!"`  
**Função sugerida:** `String renderTemplate(String template, Map<String,dynamic> ctx)`

---

### 15. Distância de Levenshtein
**Exemplo:** `"kitten"` vs `"sitting"` → `3`  
**Função sugerida:** `int levenshtein(String a, String b)`

---

### 16. Validar e formatar CPF
**Exemplo:** `"11144477735"` → `"111.444.777-35"`  
**Funções sugeridas:** `bool isValidCpf(String cpf)` e `String formatCpf(String cpf)`

---

### 17. Autocorreção simples
**Exemplo:** `"appple"` → `"apple"`  
**Função sugerida:** `String suggest(String word, List<String> dict)`

---

### 18. Extrair e normalizar nomes próprios
**Exemplo:** `"guilherme ramos da silva"` → `"Guilherme Ramos da Silva"`  
**Função sugerida:** `String normalizeName(String s)`

---

### 19. Minificador de HTML básico
Remova espaços e comentários sem quebrar tags `<pre>` ou `<code>`.  
**Função sugerida:** `String minifyHtml(String html)`

---

### 20. Motor de busca fuzzy
**Exemplo:** query `"dart"` em `["Dartlang", "Learn Dart", "Start"]` → ordenado por relevância.  
**Função sugerida:** `List<String> fuzzySearch(String q, List<String> items, {int limit = 10})`

---

🎯 **Sugestões de prática:**
- Implemente um por dia e adicione testes unitários.  
- Compare sua saída com exemplos reais.  
- Depois, reescreva usando expressões regulares, `StringBuffer`, ou manipulação manual de `runes`.

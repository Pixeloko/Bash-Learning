[Exercises source](https://www.labri.fr/perso/jbruneau/EI/regex/#partie-3---mise-en-pratique)
* Créer un répertoire essai-grep dans votre home directory. Dans ce répertoire créer les fichiers suivants: tomate, poire, pomme, cerise, Fraise, fraise, courgette, POMME3, afraise.

```bash
cd
mkdir essai-grep
cd essai-grep
touch tomate poire pomme cerise Fraise fraise courgette POMME3 afraise
```

* Filtrer la sortie de la commande ls (sortie de la commande ls redirigée vers grep avec ls * | grep -E --color 'regex') avec les critères sur leur nom suivant: 
&rarr; Critère 1: Le nom doit être Fraise ou fraise
&rarr; Critère 2: se est en fin de nom
&rarr; Critère 3: ai est présent dans le nom
&rarr; Critère 4: Nom contenant un chiffre numérique
&rarr; Critère 5: Nom contenant la chaîne mm ou MM
```bash
ls * | grep '[Ff]rai(se)$' | grep '[0-9]' | grep '[mM]'
```

-----------------------------------------------------------
* Le fichier american-english.txt situé à /net/npers/jbruneauqueyreix/american-english.txt contient les mots courants de la langue anglaise (avec accords et conjugaisons), à raison de un mot par ligne. Le mot barbecued contient les lettres a, b, c et d dans l’ordre.
Question Y’a t’il des mots anglais dans le fichier qui contiennent les lettres a, b, c, d et e dans l’ordre ? (Les autres lettres peuvent être quelconques.) Donnez l’expression régulière que vous utilisez.
```bash
grep -E --color 'a.*b.*c.*d.*e' /net/npers/jbruneauqueyreix/american-english.txt
```
-----------------------------------------------------------
* Questions Donner une expression régulière qui liste tout les mots contenant une lettre doublée, comme “blossom” ou “zoom”.
```bash
grep -E '(.)\1' 
```

* Question Y’a t’il des mots anglais contenant une même lettre 6 fois, qui n’est pas le “s”? Donnez la ligne de commande que vous utilisez.
```bash
grep -E '[A-Ra-rt-zT-Z]\1{5}'
```
-----------------------------------------------------------
```bash
$ grep 'nn' american-english | grep 'pp'
```
* Question Cherchez la liste des mots anglais qui satisfont les deux conditions suivantes : (1) il commencent et terminent par la même lettre, (2) il contiennent une lettre répétée au moins 5 fois dans le mot (la première et dernière peuvent compter).
```bash
grep -E --color '^(.).*\1$' file | grep -E '(.)\1{4}.*'
```


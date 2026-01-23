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

-----------------------------------------------------------
* Create a regex to test emails
```bash
#!/bin/bash

# Regular expression for email validation
regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# Test cases
emails=(
    "galilea.mehmut@example.com"
    "galilea_mehmut123@example.co.uk"
    "ayuba.tama123@example.io"
    "ayuba-tama@example.info"
    "user+name@example.co"
    "user.name@sub.domain.example.com"
    "invalid-email@com"
    "@example.com"
    "user@.com"
    "user@com."
)

# Function to test the regex against each email
function test_email {
    local email=$1
    if [[ $email =~ $regex ]]; then
        echo "$email - Match"
    else
        echo "$email - No Match"
    fi
}

# Loop through each email and test it
for email in "${emails[@]}"; do
    test_email "$email"
done

# Exit and run 
./test.sh
```

* Match the first section, no the second

06 12 34 56 78
+33 6 12 34 56 78
06.12.34.56.78
0612345678

06 12 34 56
06123456789 (trop long)
06-12-34-56-78-90
```bash
^(?:\+33|0)[1-9]\d{8}$
```

* Capture day, month and year into groups 

23/01/2024
23-01-2024
2024/01/23
```bash
/^(?:(?<day>\d{2})[\/-](?<month>\d{2})[\/-](?<year>\d{4})|(?<year>\d{4})[\/-](?<month>\d{2})[\/-](?<day>\d{2}))$/gm
```

* Match the first section of hex and refuse the second 

#FFFFFF
#fff
#123abc
#456

#fffff (5 caractères)
#ggg (caractères invalides)
FFFFFF (pas de #)
```bash
/^#([0-9A-F]{3}|[0-9A-F]{6})$/i
```
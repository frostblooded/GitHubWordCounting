# GitHubWordCounting
A script that counts the words from 1M Java code, 1M Ruby code, 1M C++ code, merges the results and outputs a JSON file for every language.

You can run the script with the test data as follows:

```ruby -I src/ main.rb -d test_data/ json```

If you want to download all repositories, just tun download_repos.sh as follows:

```bash download_repos.sh```


**TO DO:**

1. Аз имам някакъв файл за създаване на svg. Криси да го замени с нейния и да го подкара. Аз в main.rb точно подавам json на това дето прави svg, така че би трябвало нейното да тръгне пак така.

2. Направете някак да се разпознава какъв е кода. Май ще е най-добре file_parser.rb да гледа разширението и да казва на parser какво парсва. Най-добре ще е май да подава символ/константен стринг(тези дето са такива - :maika_ti, :ivan...)

3. Ясен да провери дали рубито бачка, защото в момента май трябва да си работи. За трети път ще кажа, за всеки случай, че е ясно, че бъгва като в коментар на един ред има ", ама това е най-доброто, което измислих.

4. Ако някой може да измисли по-добър regex за коментарите на един ред в руби, да го направи.

5. Да "преведете" regex-овете за Руби, за да работят за коментари в C++ и Java. Всъщност, както искате го направете де, ама така май ще е лесно и ще стане.

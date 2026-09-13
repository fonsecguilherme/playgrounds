
# Planejamento de estudos — App Contador

Este documento organiza o que aprender sobre **layout XML** e como evoluir o **App Contador** de forma progressiva, partindo do código que você já tem hoje.

Cada fase traz uma lista de **leituras recomendadas** (docs oficiais, guias e codelabs). Prefira a ordem sugerida: leia o guia curto, pratique no app e só então aprofunde no codelab.

Cada fase de layout (1–6) inclui uma seção **Passo a passo da prática** com instruções detalhadas — o que abrir, o que editar, como validar e por quê.

Marcações `[x]` indicam o que **já está no código**. Passos `[ ]` ainda não foram feitos. Se o texto de uma fase concluída falar “hoje o Guideline usa 500dp”, ignore: isso era o estado *na época em que a fase foi escrita*.

### Convenções que evitam os erros mais comuns

- **`@+id/nome`** só na declaração (`android:id`). Para *referenciar* uma view que já existe, use **`@id/nome`**. `@+id` numa constraint também “funciona” (cria o id em `R.id` se ainda não existir), mas mistura declaração com uso e dificulta achar erros.
- **Constraint só entre irmãos.** `app:layout_constraint…="@id/x"` só é válido se `x` for filho **direto** do mesmo `ConstraintLayout`. View dentro de um `<include>` com raiz `ConstraintLayout` **não** é irmã das views do arquivo pai.
- **`<include layout="...">`** — o atributo é `layout`, sem prefixo `android:`.
- **View Binding e `<include>`:**
  - Include **com** `android:id` e raiz que é uma `View` real → binding aninhado (`binding.counterActions.botaoIncrementar`).
  - Include **sem** `android:id` e raiz `<merge>` → os ids **não** sobem para `ActivityMainBinding`. Use `LayoutCounterDisplayBinding.bind(binding.root)` / `LayoutCounterActionsBinding.bind(binding.root)`. **Não** coloque `android:id` nem `android:layout_*` no `<include>` quando a raiz for `<merge>` (`merge` não é uma View).
- **Girar a tela recria a Activity.** O contador volta a `0` até existir `ViewModel` (Fase C). Isso não é bug de layout.

---

## Estado atual do projeto

| Item | Situação |
|------|----------|
| Tela | Uma `MainActivity` |
| Layout | `activity_main.xml` (`ConstraintLayout`) inclui dois arquivos com **`<merge>`** |
| Peças | `layout_counter_display.xml` (`TextView` contador) + `layout_counter_actions.xml` (Guideline + 2 botões) |
| Lógica | Contador em variável local (`contador`) — zera ao rotacionar/fechar |
| Binding | View Binding: `ActivityMainBinding` + `LayoutCounterDisplayBinding.bind(root)` / `LayoutCounterActionsBinding.bind(root)` |
| UI moderna | Edge-to-edge com padding de system bars em Kotlin |
| Fragments | Ainda não |
| Persistência | Ainda não |
| Arquitetura | Activity “monolítica” (UI + lógica juntas) |

**Arquivos centrais hoje:**
- `app/src/main/res/layout/activity_main.xml`
- `app/src/main/res/layout/layout_counter_display.xml`
- `app/src/main/res/layout/layout_counter_actions.xml`
- `app/src/main/java/com/example/appcontador/MainActivity.kt`

---

## O que aprender sobre layout XML (trilha sugerida)

Ordem pensada para ir do que você **já usa** até conceitos que aparecem em apps reais.

### Fase 1 — Fundamentos (você já começou aqui)

**Conceitos**
- Estrutura de um arquivo XML: namespace `android`, `app`, `tools`
- Atributos essenciais: `layout_width`, `layout_height`, `android:id`, `android:text`
- Unidades: `dp` (tamanho), `sp` (texto), `match_parent` vs `wrap_content`
- `@+id/nome` (criar id) vs `@id/nome` (referenciar id existente)
- `@string/`, `@color/`, `@dimen/` — externalizar recursos

**Prática no App Contador**
- [x] Mover textos dos botões para `strings.xml`
- [x] Criar `dimens.xml` com margens (`16dp`) e tamanho do texto (`30sp`)
- [x] Usar `@color/` no `TextView` em vez de cor implícita

#### Passo a passo da prática

**1. Externalizar strings (`strings.xml`)**

Abra `app/src/main/res/values/strings.xml` e adicione entradas para cada texto visível na tela:

```xml
<string name="incrementar">Incrementar</string>
<string name="decrementar">Decrementar</string>
<string name="_0">0</string>
```

O nome `_0` existe porque o nome de um recurso **não pode começar com dígito**. `name="0"` não compila; o underscore é o truque usual.

No `activity_main.xml` (hoje: nos XMLs incluídos), troque textos literais por referências:

```xml
android:text="@string/incrementar"
```

**Por quê?** Facilita tradução, evita typos espalhados pelo XML e centraliza textos em um só lugar.

**2. Criar dimensões (`dimens.xml`)**

Crie `app/src/main/res/values/dimens.xml`:

```xml
<resources>
    <dimen name="margin16DP">16dp</dimen>
    <dimen name="mainTextSize">30sp</dimen>
</resources>
```

Use nos atributos de margem e tamanho de texto:

```xml
android:layout_margin="@dimen/margin16DP"
android:textSize="@dimen/mainTextSize"
```

**Por quê?** Se amanhã quiser margem `24dp` em todo o app, muda em um arquivo só.

**3. Usar cores de recurso (`colors.xml`)**

Em `colors.xml`, defina a cor do texto. No `TextView` do contador:

```xml
android:textColor="@color/black"
```

**Por quê?** No tema escuro (Fase 4), você poderá trocar `@color/black` por uma cor que funcione nos dois modos.

**4. Como validar**

- Rode o app: deve parecer igual visualmente.
- Abra `activity_main.xml` no modo **Design** e confira se não há warnings de hardcoded strings.

**Referência no seu código**

Você já centraliza o contador e ancora os botões abaixo dele com constraints — isso é o coração do `ConstraintLayout`:

```xml
app:layout_constraintTop_toBottomOf="@id/contador"
app:layout_constraintStart_toStartOf="parent"
app:layout_constraintEnd_toStartOf="@id/guideline_vertical"
```

**Leituras**
- [Layouts em XML — Declaring a layout](https://developer.android.com/develop/ui/views/layout/declaring-layout)
- [View e ViewGroup — Visão geral](https://developer.android.com/guide/topics/ui/overview)
- [App resources overview](https://developer.android.com/guide/topics/resources/providing-resources)
- [String resources](https://developer.android.com/guide/topics/resources/string-resource)
- [Dimension resources](https://developer.android.com/guide/topics/resources/more-resources#Dimension)
- [Color resources](https://developer.android.com/guide/topics/resources/more-resources#Color)
- [Support different pixel densities (dp/sp)](https://developer.android.com/training/multiscreen/screendensities)
- Curso (pode estar arquivado em favor de Compose): [Android Basics with Views — Unit 1](https://developer.android.com/courses/android-basics-kotlin/course)

---

### Fase 2 — ConstraintLayout aprofundado

**Conceitos**
- Cadeias horizontais/verticais (`spread`, `packed`, `spread_inside`)
- Bias (`layout_constraintHorizontal_bias`)
- Guidelines e Barriers (alinhar sem aninhar layouts)
- `0dp` (= `match_constraint`) para dividir espaço entre views irmãs
- `layout_margin` vs `padding`
- `layout_constraintWidth_percent` para layouts responsivos

**Prática no App Contador**
- [x] Entender **cadeia horizontal** (técnica A) e **Guideline** (técnica B) — o app ficou com a B
- [x] `Guideline` vertical em 50% (`layout_constraintGuide_percent="0.5"`)
- [x] Testar rotação de tela e tamanhos diferentes no Layout Inspector

#### Passo a passo da prática

**Contexto:** dividir a largura em duas metades iguais dá para fazer de **dois jeitos**. Não ligue os dois ao mesmo tempo.

| Técnica | Como os botões se conectam | Quando usar |
|---------|----------------------------|-------------|
| **Cadeia (chain)** | Incrementar ↔ Decrementar (ciclo entre eles) + pontas no parent | Espaço compartilhado, pesos, `spread` / `packed` |
| **Guideline** | Cada botão ancora na linha de 50%, **não** um no outro | “Metade da tela” como referência fixa |

O app **hoje usa Guideline**, não cadeia: `botao_incrementar` termina na guideline; `botao_decrementar` começa nela.

---

**Prática 1 — Cadeia horizontal (conceito; opcional no código atual)**

**O que é uma cadeia (chain)?**

Uma cadeia existe só quando há **constraints bidirecionais** entre views vizinhas:

```
parent.Start ← Incrementar ↔ Decrementar → parent.End
```

Ou seja: o `End` do primeiro aponta para o `Start` do segundo **e** o `Start` do segundo aponta para o `End` do primeiro. Sem esse ciclo, **não há chain** — `chainStyle` não faz nada.

Quando a cadeia existe, o `ConstraintLayout` decide como o espaço extra é distribuído.

**Passos (se for experimentar cadeia no lugar da guideline):**

1. **Ciclo de constraints**
   - `botao_incrementar`: `Start` → pai; `End` → início de `botao_decrementar`
   - `botao_decrementar`: `Start` → fim de `botao_incrementar`; `End` → pai
   - **Remova** as âncoras na `guideline_vertical` (senão deixa de ser chain).

2. **`layout_width="0dp"` nos dois** — no `ConstraintLayout`, `0dp` = `MATCH_CONSTRAINT` (“ocupe o espaço que as constraints derem”). `match_parent` **dentro** de ConstraintLayout não é o equivalente correto; prefira `0dp` + âncoras nas duas pontas.

3. **Estilo só no “cabeça” da cadeia** (o item mais à esquerda em LTR):

   ```xml
   app:layout_constraintHorizontal_chainStyle="spread"
   ```

4. **Estilos:**

   | Estilo | Comportamento |
   |--------|---------------|
   | `spread` | Padrão. Com `0dp`, os widgets `MATCH_CONSTRAINT` **dividem o espaço restante** (pesos iguais se você não definir weight). |
   | `spread_inside` | Primeiro e último colados nas pontas; espaço extra só *entre* eles. |
   | `packed` | Agrupados. Com `0dp` + weight, **não** use `packed` — os itens `MATCH_CONSTRAINT` podem colapsar. `packed` combina com `wrap_content`. |

   Pesos explícitos (opcional): `app:layout_constraintHorizontal_weight="1"` em cada botão. Dois botões com weight 1 ocupam metades iguais.

5. **Kotlin não muda** — os ids continuam os mesmos.

---

**Prática 2 — Guideline vertical em 50% (é o que o app usa)**

**O que é um Guideline?**

Linha **invisível**. Não ocupa toque nem desenho. Serve só de âncora. Não é irmã “especial”: as views ainda precisam ser filhas do mesmo `ConstraintLayout`.

- `android:orientation="vertical"` → linha **vertical** (corta a tela em esquerda/direita). A posição é no eixo X: `percent` é fração da **largura**.
- `android:orientation="horizontal"` → linha **horizontal** (cima/baixo). `percent` é fração da **altura**.

Um Guideline vertical **tem** topo e base (em geral a altura do parent). `layout_constraintBottom_toBottomOf="@id/guideline_vertical"` ancora o **fundo da view no fundo da guideline** (quase sempre = fundo do parent). Não é “ancorar numa linha horizontal”. Só é redundante. Âncoras úteis num guideline **vertical**: `Start` / `End`. Num **horizontal**: `Top` / `Bottom`.

**Passos:**

1. Se ainda existir posição fixa em dp, troque por percentual:

   ```xml
   <androidx.constraintlayout.widget.Guideline
       android:id="@+id/guideline_vertical"
       android:layout_width="wrap_content"
       android:layout_height="wrap_content"
       android:orientation="vertical"
       app:layout_constraintGuide_percent="0.5" />
   ```

   Alternativas: `layout_constraintGuide_begin` / `end` em `dp` (distância de uma borda). Percentual adapta a qualquer largura.

2. Ancore os botões **na linha**, não um no outro:

   ```xml
   app:layout_constraintEnd_toStartOf="@id/guideline_vertical"   <!-- incrementar -->
   app:layout_constraintStart_toEndOf="@id/guideline_vertical"  <!-- decrementar -->
   ```

3. No Preview, troque o dispositivo (Pixel, Tablet…). A linha fica no meio. Com `begin="500dp"`, em tela estreita a linha pode sair da área visível.

---

**Prática 3 — Rotação de tela e Layout Inspector**

**Passos:**

1. Rode o app no emulador ou celular.

2. **Gire a tela.** Observe layout (botões, centralização). O **número volta a 0**: a Activity é destruída e `onCreate` roda de novo; `private var contador = 0` recomeça. Corrigir isso é Fase C (`ViewModel`), não XML.

3. **Layout Inspector** (**View → Tool Windows → Layout Inspector**):
   - **Hierarquia:** com `<merge>`, continua “flat”: `ConstraintLayout` → `TextView` + 2 `Button`s + `Guideline` (os includes **não** aparecem como grupos).
   - **Constraints** e larguras reais de cada botão.

4. Teste tamanhos no Preview (Pixel Tablet, Small Phone).

**Por que importa:** layout que só funciona no seu celular quebra em tablet ou landscape. A Fase 5 (`layout-land/`) é um *segundo arquivo*; a Fase 2 ensina o mesmo XML a se adaptar.

---

**Referência — XML atual dos botões (Guideline, não chain):**

```xml
<Button
    android:id="@+id/botao_incrementar"
    android:layout_width="0dp"
    android:layout_height="wrap_content"
    android:layout_margin="@dimen/margin16DP"
    android:text="@string/incrementar"
    android:textAllCaps="true"
    app:layout_constraintBottom_toBottomOf="parent"
    app:layout_constraintEnd_toStartOf="@id/guideline_vertical"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toBottomOf="@id/contador" />

<Button
    android:id="@+id/botao_decrementar"
    android:layout_width="0dp"
    android:layout_height="wrap_content"
    android:layout_margin="@dimen/margin16DP"
    android:text="@string/decrementar"
    android:textAllCaps="true"
    app:layout_constraintBottom_toBottomOf="parent"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintStart_toEndOf="@id/guideline_vertical"
    app:layout_constraintTop_toBottomOf="@id/contador" />

<androidx.constraintlayout.widget.Guideline
    android:id="@+id/guideline_vertical"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    app:layout_constraintGuide_percent="0.5" />
```

`Top_toBottomOf` + `Bottom_toBottomOf="parent"` coloca os botões no espaço **entre** o número e a base (bias vertical 0,5 por padrão). Só `Top_toBottomOf` sem âncora de baixo encosta os botões logo abaixo do texto.

**Checklist da Fase 2**

| Item | Ação concreta |
|------|----------------|
| Uma técnica só | Ou chain (botões ligados entre si) **ou** Guideline (botões ligados à linha) |
| Guideline 50% | `orientation="vertical"` + `layout_constraintGuide_percent="0.5"` (estado atual) |
| Layout Inspector | Rodar, girar (aceitar reset do número), inspecionar hierarquia flat |

**Por que importa:** a maioria dos layouts modernos em XML ainda usa `ConstraintLayout` por ser flat (poucos níveis de aninhamento) e performático.

**Leituras**
- [Build a responsive UI with ConstraintLayout](https://developer.android.com/develop/ui/views/layout/constraint-layout)
- [ConstraintLayout — reference (API)](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout)
- [Chains (documentação oficial)](https://developer.android.com/develop/ui/views/layout/constraint-layout#constrain-chain)
- [Guidelines](https://developer.android.com/develop/ui/views/layout/constraint-layout#constrain-guideline)
- [Barriers](https://developer.android.com/develop/ui/views/layout/constraint-layout#constrain-barrier)
- Codelab: [ConstraintLayout](https://developer.android.com/codelabs/constraint-layout)
- Vídeo/guia: [Use ConstraintLayout to design your Android views](https://developer.android.com/codelabs/constraint-layout#0)

---

### Fase 3 — Outros ViewGroups e composição

**Conceitos**
- `LinearLayout` (vertical/horizontal) — simples, mas aninhamento excessivo prejudica performance
- `FrameLayout` — útil para sobrepor views (base de Fragments)
- `ScrollView` / `NestedScrollView` — conteúdo maior que a tela
- `RecyclerView` + item layout — listas (etapa mais adiante)
- `<include>` — reutilizar pedaços de layout
- `<merge>` — reduzir profundidade da árvore de views
- `<ViewStub>` — layout lazy (só infla quando necessário)

**Prática no App Contador**
- [x] Extrair `layout_counter_display.xml` e incluir com `<include>`
- [x] Extrair `layout_counter_actions.xml` com os botões e a Guideline

#### Passo a passo da prática

**Objetivo:** quebrar o XML em pedaços reutilizáveis **sem mudar a árvore de views em runtime**.

Neste app as peças **dependem umas das outras** (botão ancora em `@id/contador`; botões ancoram na Guideline). O recorte que preserva isso é **`<merge>`**, não um `ConstraintLayout` extra em cada arquivo.

---

**Dois modelos — escolha um e seja consistente**

| | **Bloco** (raiz `ConstraintLayout` / `LinearLayout` / `Card`) | **Injeção** (raiz `<merge>`) — **é o que o projeto usa** |
|---|---|---|
| Em runtime | Cada include é um grupo a mais na árvore | Views entram no `ConstraintLayout` pai; árvore igual à Fase 2 |
| Constraints | Só entre irmãos **daquele** XML. O pai constrange o **include** (`@id/counter_display`) | Views podem usar ids do pai (`@id/contador`) porque, depois do inflate, são irmãs |
| `<include>` | Pode ter `android:id`, `layout_width`/`height` e `app:layout_constraint*` | **Sem** `android:id` e **sem** `android:layout_*` (`merge` não é View) |
| Binding | `binding.counterDisplay.contador` | `LayoutXBinding.bind(pai.root).contador` (ids **não** sobem ao pai) |
| Layout Validation | O Android Studio valida o XML **como tela**. Botões `0dp` a 50% + `bottom_toBottomOf="parent"` geram “too wide” e “covered by System UI” mesmo que a activity pai não tivesse esses avisos | A tela analisada continua sendo `activity_main.xml` |

**Não misture:** não coloque raiz `ConstraintLayout`, `android:id` no include, `constraintTop_toBottomOf="@id/contador"` e o padrão de binding de merge ao mesmo tempo. Isso foi o que gerou os avisos da Fase 3.

---

**O que o projeto tem hoje**

`activity_main.xml`:

```xml
<androidx.constraintlayout.widget.ConstraintLayout ...>

    <include layout="@layout/layout_counter_display" />

    <include layout="@layout/layout_counter_actions" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

Cada filho usa `<merge>` + atributos **só de editor**:

- `tools:parentTag="androidx.constraintlayout.widget.ConstraintLayout"` — o Preview trata o `merge` como se o pai fosse um ConstraintLayout.
- `tools:showIn="@layout/activity_main"` — abre o pedaço **no contexto da activity**, não como tela vazia. Constraints para `@id/contador` no arquivo de ações passam a resolver.

As constraints (`Top`/`Bottom`/`Start`/`End`, Guideline) ficam **dentro dos arquivos merge**, apontando para `parent` (o ConstraintLayout da activity) e para ids que existirão depois do inflate.

---

**Se no futuro um pedaço for autônomo** (ex.: um card que não ancora em views de fora), aí sim vale o modelo **bloco**: raiz `MaterialCardView` ou `ConstraintLayout`, `<include android:id=...>` com constraints **no include**, e ids internos só entre si. A Guideline dos botões iria **junto** dos botões, nunca referenciada de outro arquivo.

---

**View Binding (resumo)**

```kotlin
// merge, include sem id (hoje) — bind no root do pai:
val displayBinding = LayoutCounterDisplayBinding.bind(binding.root)
val actionsBinding = LayoutCounterActionsBinding.bind(binding.root)
displayBinding.contador
actionsBinding.botaoIncrementar
actionsBinding.botaoDecrementar

// bloco, include com id (outro modelo):
binding.counterDisplay.contador
binding.counterActions.botaoIncrementar
```

`ActivityMainBinding` **não** expõe `contador` / botões quando os filhos vêm de `<merge>`. Se o Kotlin não achar o campo no pai, use o `*Binding.bind(root)` do pedaço — Rebuild sozinho não cria esses campos no pai. Se você colocou `android:id` num include cujo layout é `<merge>`, o inflate pode falhar (`Missing required view`).

**Por quê fazer isso?** Na Fase B você reutiliza os mesmos pedaços num `fragment_counter.xml` sem copiar XML. Com `merge`, o fragment precisa de um `ConstraintLayout` (ou outro ViewGroup) como pai do include — igual à activity.

**Leituras**
- [LinearLayout](https://developer.android.com/develop/ui/views/layout/linear)
- [FrameLayout](https://developer.android.com/reference/android/widget/FrameLayout)
- [ScrollView](https://developer.android.com/reference/android/widget/ScrollView)
- [Re-using layouts with `<include>`](https://developer.android.com/develop/ui/views/layout/improving-layouts/reusing-layouts)
- [Merge layout files (`<merge>`)](https://developer.android.com/develop/ui/views/layout/improving-layouts/reusing-layouts#merge)
- [Load views on demand (`ViewStub`)](https://developer.android.com/develop/ui/views/layout/improving-layouts/loading-ondemand)
- [Improving Layout Performance](https://developer.android.com/develop/ui/views/layout/improving-layouts)
- [View Binding](https://developer.android.com/topic/libraries/view-binding) *(você já usa — vale reler)*

---

### Fase 4 — Material Components e temas

**Conceitos**
- `MaterialButton`, `TextInputLayout`, `CardView`, `Chip`
- Temas (`themes.xml`) vs estilos (`styles.xml`)
- `Material 3` color roles: `colorPrimary`, `colorOnPrimary`, etc.
- Modo claro/escuro (`values-night/`)
- `contentDescription` para acessibilidade

**Prática no App Contador**
- [ ] Trocar `Button` por `com.google.android.material.button.MaterialButton`
- [ ] Envolver o contador em um `MaterialCardView`
- [ ] Definir estilo `CounterText` em `styles.xml` e aplicar no `TextView`
- [ ] Garantir contraste legível no tema escuro

#### Passo a passo da prática

**Pré-requisito:** confirme que a dependência Material já está no projeto (geralmente vem com templates recentes):

```kotlin
// app/build.gradle.kts
implementation(libs.material) // ou com.google.android.material:material
```

---

**Prática 1 — MaterialButton**

1. O tema do app já é `Theme.Material3.DayNight.NoActionBar`. Com esse tema, o inflater do AppCompat/Material **substitui** `<Button>` por `MaterialButton` em runtime. Trocar a tag no XML **não muda o visual sozinho**; serve para atributos Material (`app:icon`, `app:cornerRadius`) e para o tipo gerado no View Binding.

2. Se for deixar explícito, em `layout_counter_actions.xml` troque `<Button` por:

   ```xml
   <com.google.android.material.button.MaterialButton
       android:id="@+id/botao_incrementar"
       ... />
   ```

   `style="@style/Widget.Material3.Button"` é o padrão desse tema; só precisa se você tiver outro style no botão e quiser forçar o filled button.

3. Os ids e listeners em Kotlin **não precisam mudar** (MaterialButton é subclasse de Button).

4. Opcional: `app:icon` para ícones +/−. Aí sim vale `android:contentDescription` (botão só com ícone não tem texto visível para o leitor de tela). Botão **com texto** (“Incrementar”) não precisa de `contentDescription`.

---

**Prática 2 — MaterialCardView em volta do contador**

O display está num `<merge>`. **Não** envolva o `<include>` em `activity_main.xml`: include+merge não é uma View, não recebe constraints.

Coloque o Card **dentro** de `layout_counter_display.xml`, como filho do `merge`. As constraints que hoje estão no `TextView` passam para o Card; o `TextView` fica só como conteúdo do Card (`MaterialCardView` é um `FrameLayout` — filhos **não** usam constraints do ConstraintLayout pai).

```xml
<merge ... tools:parentTag="androidx.constraintlayout.widget.ConstraintLayout"
    tools:showIn="@layout/activity_main">

    <com.google.android.material.card.MaterialCardView
        android:id="@+id/counter_card"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        app:cardElevation="4dp"
        app:cardCornerRadius="12dp"
        app:contentPadding="24dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent">

        <TextView
            android:id="@+id/contador"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="@string/_0"
            android:textSize="@dimen/mainTextSize" />
    </com.google.android.material.card.MaterialCardView>
</merge>
```

`displayBinding.contador` continua válido (o id `@+id/contador` não saiu do merge). Os botões que usam `Top_toBottomOf="@id/contador"` passam a ancorar no **TextView**, que está *dentro* do Card — o Card pode ficar maior que o texto (padding). Prefira ancorar em `@id/counter_card` para o espaço abaixo considerar o Card inteiro.

---

**Prática 3 — Estilo reutilizável**

1. O template recente só traz `themes.xml`. Criar `app/src/main/res/values/styles.xml` é válido; também pode declarar o style dentro de `themes.xml`. Não misture `parent` de AppCompat antigo (`Theme.AppCompat`) com Material 3 sem querer.

   ```xml
   <resources>
       <style name="CounterText">
           <item name="android:textSize">@dimen/mainTextSize</item>
           <item name="android:textColor">?attr/colorOnSurface</item>
           <item name="android:textStyle">bold</item>
       </style>
   </resources>
   ```

2. No `TextView`: `style="@style/CounterText"` — remova atributos duplicados que o estilo já define.

---

**Prática 4 — Tema escuro**

1. `values-night/themes.xml` do template já redefine `Base.Theme.AppContador`. Ajuste ali; não crie um segundo app theme com outro nome.

2. Troque `@color/black` fixo por `?attr/colorOnSurface`. Se o estilo `CounterText` da prática 3 já usa `?attr/colorOnSurface`, este passo no `TextView` fica feito.

3. No emulador: **Settings → Display → Dark theme** e valide contraste. `@color/black` em fundo escuro some o texto — por isso o atributo de tema, não a cor crua.

**Leituras**
- [Material Design for Android](https://developer.android.com/develop/ui/views/theming/look-and-feel)
- [Styles and themes](https://developer.android.com/develop/ui/views/theming)
- [Dark theme](https://developer.android.com/develop/ui/views/theming/darktheme)
- [Material Components for Android (GitHub)](https://github.com/material-components/material-components-android)
- [Material Button](https://github.com/material-components/material-components-android/blob/master/docs/components/Button.md)
- [Material Card](https://github.com/material-components/material-components-android/blob/master/docs/components/Card.md)
- [Material Color roles (M3)](https://m3.material.io/styles/color/roles)
- [Make apps more accessible](https://developer.android.com/guide/topics/ui/accessibility/apps)
- [contentDescription](https://developer.android.com/reference/android/view/View#attr_android:contentDescription)

---

### Fase 5 — Layouts alternativos e adaptação

**Conceitos**
- `layout-land/` — layout diferente em paisagem
- `layout-sw600dp/` — tablets
- Qualificadores: `-night`, `-xlarge`, `-hdpi` (drawables)
- Preview no Android Studio com Device configurável

**Prática no App Contador**
- [ ] Criar `layout-land/activity_main.xml`: contador à esquerda, botões à direita
- [ ] Validar que View Binding gera o mesmo `ActivityMainBinding` (mesmos ids)

#### Passo a passo da prática

**Objetivo:** quando o usuário gira o celular, usar um layout **otimizado para paisagem** em vez de só esticar o portrait.

`activity_main.xml` hoje só tem dois `<include>`. **Copiar esse arquivo para `layout-land/` não muda o visual** — o sistema continua inflando os mesmos `layout_counter_display` / `layout_counter_actions` (portrait). O qualificador vale para **o arquivo que de fato contém as constraints**.

**Caminho alinhado ao `<merge>` (recomendado):**

1. Clique com botão direito em `res` → **New → Android Resource Directory**.
2. Resource type **layout**, qualificador **Orientation → Landscape** → cria `res/layout-land/`.
3. Crie **cópias** (não mova) com os **mesmos nomes**:
   - `layout-land/layout_counter_display.xml`
   - `layout-land/layout_counter_actions.xml`
4. Mantenha os **mesmos ids** (`contador`, `botao_incrementar`, `botao_decrementar`, `guideline_vertical` se ainda usar). Mude só constraints: número à esquerda, botões à direita (cadeia **vertical** ou um abaixo do outro).
5. `activity_main.xml` pode ficar único em `layout/`. `@layout/layout_counter_display` resolve sozinho para a versão `-land` em paisagem.

**Caminho alternativo:** um `layout-land/activity_main.xml` **inline** (sem include), com os mesmos ids. Aí você duplica XML; o binding continua o mesmo.

**Não faça:** `layout-land/activity_main.xml` idêntico ao portrait (só includes) achando que o landscape “redesenha” sozinho.

Qualificador `-xlarge` é legado; para tablets prefira `-sw600dp` (smallest width).

---

**Prática 2 — Validar View Binding**

1. **Build → Rebuild Project**.

2. Confirme que `LayoutCounterDisplayBinding` / `LayoutCounterActionsBinding` ainda expõem `contador`, `botaoIncrementar`, `botaoDecrementar` (não espere esses campos em `ActivityMainBinding`).

3. Rode o app e gire a tela — a UI deve mudar para o layout-land **sem alterar** `MainActivity.kt`.

**Regra de ouro:** layouts alternativos são arquivos **diferentes**, mas com os **mesmos ids**. A Activity/Fragment não sabe qual XML foi inflado.

**Leituras**
- [Support different screen sizes](https://developer.android.com/guide/topics/large-screens/support-different-screen-sizes)
- [Provide alternative resources](https://developer.android.com/guide/topics/resources/providing-resources#AlternativeResources)
- [App resources — configuration qualifier names](https://developer.android.com/guide/topics/resources/providing-resources#table2)
- [Handle configuration changes](https://developer.android.com/guide/topics/resources/runtime-changes) — **não** use `android:configChanges` no Manifest para “impedir” a recriação da Activity; o caminho certo para estado é `ViewModel` (Fase C).
- [Design for large screens](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality)

---

### Fase 6 — Ferramentas de inspeção e qualidade

**Conceitos**
- Layout Inspector (hierarquia ao vivo)
- Lint de acessibilidade (touch target mínimo 48dp)
- ConstraintLayout Visual Editor (arrastar constraints)
- Preview com `@tools:text` (só no editor, não vai para o APK)

**Prática**
- [ ] Adicionar `tools:text="42"` no `TextView` para preview
- [ ] Corrigir warnings do lint relacionados a layout

#### Passo a passo da prática

---

**Prática 1 — Atributos `tools:` (só no editor)**

1. No `TextView` do contador (`layout_counter_display.xml`), adicione `xmlns:tools` no `<merge>` (já existe) e:

   ```xml
   android:text="@string/_0"
   tools:text="42"
   ```

2. No **Preview** do Android Studio, você verá `42`; no app real, continua `@string/_0` (valor inicial).

3. Use `tools:context=".MainActivity"` na **activity** (já existe). Nos arquivos `<merge>`, `tools:showIn="@layout/activity_main"` faz o mesmo papel de contexto.

4. **Layout Validation vs edge-to-edge:** o app aplica padding das system bars **em Kotlin**. O validador de layout olha só o XML. Views com `Bottom_toBottomOf="parent"` podem aparecer como “covered by System UI” no painel mesmo com o padding correto em runtime. Isso não significa que o XML da Fase 2/3 esteja errado. Preferir validar em `activity_main.xml` (a tela), não tratar cada merge como activity.

**Por quê?** O preview fica mais útil sem hardcodar texto que iria parar no APK.

---

**Prática 2 — Lint e acessibilidade**

1. Menu **Analyze → Inspect Code…** (ou clique no warning amarelo no XML).

2. Corrija avisos comuns:
   - **Hardcoded text** → mover para `strings.xml`
   - **Touch target too small** → botões com altura mínima ~48dp ou `minHeight="48dp"`
   - **Missing `contentDescription`** em botões só com ícone (Fase 4+)

3. Rode **Build → Analyze APK** ou `./gradlew lint` para relatório completo.

---

**Prática 3 — Layout Editor e Inspector (revisão)**

1. **Design tab:** arraste constraints visualmente; compare com o XML que você escreveu na Fase 2.

2. **Layout Inspector** (app rodando): confira profundidade da árvore — idealmente 2–3 níveis, não 8+ aninhados.

**Leituras**
- [Debug your layout with Layout Inspector](https://developer.android.com/studio/debug/layout-inspector)
- [Layout Editor](https://developer.android.com/studio/write/layout-editor)
- [Design-time layout attributes (`tools:`)](https://developer.android.com/studio/write/tool-attributes)
- [Improve your code with lint checks](https://developer.android.com/studio/write/lint)
- [Accessibility scanner / lint](https://developer.android.com/guide/topics/ui/accessibility/apps#testing)
- [Touch target size (Material / accessibility)](https://m3.material.io/foundations/accessible-design/accessibility-basics#280f1527-a31b-4cd0-9aff-9341adeea4bc)

---

## Quando migrar para Jetpack Compose?

Compose é o futuro da UI Android, mas **XML ainda vale aprender** porque:
- Projetos legados e tutoriais usam XML
- `ViewBinding`, Fragments e Navigation funcionam muito bem com XML
- Entender medidas, constraints e ciclo de vida de Views ajuda a entender Compose depois

**Sugestão:** complete as Fases 1–4 em XML; considere Compose a partir da Fase H (ver roadmap abaixo), quando já tiver Fragments + ViewModel.

**Leituras (para quando chegar a hora)**
- [Jetpack Compose pathway](https://developer.android.com/courses/pathways/compose)
- [Thinking in Compose](https://developer.android.com/develop/ui/compose/mental-model)
- [Interoperability APIs (Compose ↔ Views)](https://developer.android.com/develop/ui/compose/migrate/interoperability-apis)

---

## Evolução do App Contador — roadmap de features

Cada fase adiciona **uma preocupação nova** (layout, estado, navegação, persistência…) sem pular etapas.

### Fase A — Polimento de layout e recursos (1–2 dias)

**Objetivo:** consolidar XML e boas práticas de recursos.

| Feature | O que aprende |
|---------|----------------|
| Strings e dimens externalizados | Organização de `res/` |
| MaterialButton + Card | Material Design |
| Botão “Zerar” | Mais constraints / linha de botões |
| Limite mínimo/máximo no contador | Validação na UI (desabilitar botões) |
| Feedback visual (cor muda se negativo) | `ColorStateList`, `@color` |

**Entrega:** app visualmente mais consistente, sem mudar arquitetura.

#### Passo a passo da prática

**1. Consolidar recursos (Fases 1 e 4)** — siga os passos detalhados nas Fases 1 e 4 acima se ainda não fez.

**2. Adicionar botão “Zerar”**

1. Em `strings.xml`: `<string name="zerar">Zerar</string>`
2. O layout dos botões está em `layout_counter_actions.xml` e usa Guideline a **50% para dois botões**. Um terceiro botão **não cabe** nesse esquema. Opções:
   - Trocar para **cadeia horizontal de 3** (`0dp` + ciclo entre os três + `chainStyle="spread"`) e **remover** a Guideline; ou
   - Deixar +/− na Guideline e colocar Zerar **abaixo** (constraint `Top_toBottomOf` num dos botões).
3. Id único: `@+id/botao_zerar`. Com `<merge>`, o Kotlin é `actionsBinding.botaoZerar` (via `LayoutCounterActionsBinding.bind(binding.root)`).
4. Em `MainActivity.kt` (com `displayBinding` / `actionsBinding` já criados):

   ```kotlin
   actionsBinding.botaoZerar.setOnClickListener {
       contador = 0
       displayBinding.contador.text = contador.toString()
   }
   ```

**3. Limite mínimo/máximo — desabilitar botões**

1. Defina constantes (ex.: `MIN = 0`, `MAX = 99`).
2. Crie função `atualizarUi()` que:
   - Atualiza o texto do contador
   - `actionsBinding.botaoDecrementar.isEnabled = contador > MIN`
   - `actionsBinding.botaoIncrementar.isEnabled = contador < MAX`
3. Chame `atualizarUi()` após cada clique, em vez de só mudar o texto.

**4. Feedback visual (só faz sentido se `MIN` for negativo)**

Escolha **uma** regra e siga até o fim:

- **A — não negativo:** `MIN = 0`, desabilite decrementar no zero. Não haverá cor “negativa”.
- **B — permite negativo:** não desabilite no zero; use cor diferente quando `contador < 0`.

Misturar “desabilite em `<= 0`” com “teste valor negativo” é contraditório.

1. Em `colors.xml`, adicione `counter_negative` e `counter_normal` (se for a regra B).
2. No `atualizarUi()` (regra B):

   ```kotlin
   val cor = if (contador < 0) R.color.counter_negative else R.color.counter_normal
   displayBinding.contador.setTextColor(getColor(cor))
   ```

`getColor(id)` existe na Activity com `minSdk 24`. Alternativa: `ContextCompat.getColor(this, cor)`.

**Validação:** incremente/decremente até os limites da regra que você escolheu; o botão Zerar volta a `0` e reabilita o que for preciso.

**Leituras**
- [App resources overview](https://developer.android.com/guide/topics/resources/providing-resources)
- [Material Button](https://github.com/material-components/material-components-android/blob/master/docs/components/Button.md)
- [Material Card](https://github.com/material-components/material-components-android/blob/master/docs/components/Card.md)
- [ColorStateList](https://developer.android.com/guide/topics/resources/color-list-resource)
- [Enable/disable Views (`setEnabled`)](https://developer.android.com/reference/android/view/View#setEnabled(boolean))
- Revisar Fases 1 e 4 desta trilha

---

### Fase B — Separar UI em Fragments (3–5 dias)

**Objetivo:** introduzir Fragments antes de crescer demais a Activity.

**Por que Fragment aqui?**
- Uma Activity passa a ser “host” da navegação
- Cada parte da UI ganha ciclo de vida próprio
- Prepara Bottom Navigation ou Navigation Drawer depois

**Estrutura sugerida**

```
MainActivity (host, toolbar, nav)
├── CounterFragment      → tela principal do contador
├── HistoryFragment      → histórico de alterações (placeholder inicial)
└── SettingsFragment     → passo, tema, limites (placeholder inicial)
```

**Layouts novos**
- `fragment_counter.xml` — **mesmo padrão** da activity atual: `ConstraintLayout` + os dois `<include layout="...">` (sem id). Não copie só os includes para um arquivo cuja raiz não seja ConstraintLayout: o `<merge>` precisa de um pai ConstraintLayout.
- Atualize `tools:showIn` nos merges para `@layout/fragment_counter` (ou deixe os dois showIn se ainda inflar na activity durante a transição).
- `fragment_history.xml` — lista vazia com `TextView` `@string/sem_historico`
- `fragment_settings.xml` — placeholders (`SwitchMaterial`, `Slider`)

**Activity host (`activity_main.xml`)**
- Um `ViewGroup` raiz (ConstraintLayout ou LinearLayout)
- `FragmentContainerView` com id `nav_host`
- Opcional: `BottomNavigationView` — **não** pode ser “irmão solto” sem pai; veja o XML abaixo

**Dependências a adicionar**
- `androidx.fragment:fragment-ktx`
- `androidx.navigation:navigation-fragment-ktx`
- `androidx.navigation:navigation-ui-ktx`

**Checklist**
- [ ] Criar `CounterFragment` movendo lógica de incremento/decremento
- [ ] `MainActivity` só infla host + configura Navigation
- [ ] Usar View Binding nos fragments (`FragmentCounterBinding`)
- [ ] Rotação: o número **ainda zera** até a Fase C. `viewLifecycleOwner` só entra quando houver `LiveData`/`Flow` (Fase C) — observers na *view*, não no Fragment inteiro

**Ordem pedagógica, não regra da plataforma:** você *pode* usar `ViewModel` já na `MainActivity`. Este plano faz Fragment primeiro só para a Activity virar host de navegação.

#### Passo a passo da prática

**1. Adicionar dependências** (`gradle/libs.versions.toml` + `app/build.gradle.kts`):

- `androidx.fragment:fragment-ktx`
- `androidx.navigation:navigation-fragment-ktx`
- `androidx.navigation:navigation-ui-ktx`

Sync do Gradle após salvar.

**2. Criar layouts dos fragments**

1. `fragment_counter.xml`: raiz `ConstraintLayout` (`match_parent` × `match_parent`) com os mesmos dois `<include layout="@layout/layout_counter_display" />` e `layout_counter_actions` de hoje.
2. Crie `fragment_history.xml` com um `TextView` centrado: `@string/sem_historico` (adicione a string).
3. Crie `fragment_settings.xml` com placeholders (`SwitchMaterial`, `Slider`) — lógica vem na Fase F.

**3. Criar `CounterFragment`**

1. **File → New → Fragment → Empty Fragment** (ou crie manualmente).
2. Mova de `MainActivity.kt` para `CounterFragment.kt`:
   - Variável `contador`
   - Listeners dos botões
   - Lógica de atualizar UI
3. Use View Binding:

   ```kotlin
   private var _binding: FragmentCounterBinding? = null
   private val binding get() = _binding!!

   override fun onCreateView(...): View {
       _binding = FragmentCounterBinding.inflate(inflater, container, false)
       return binding.root
   }

   override fun onDestroyView() {
       super.onDestroyView()
       _binding = null  // evita memory leak
   }
   ```

   Listeners de clique: coloque em `onViewCreated`, não em `onCreateView` (a view já existe; é o ponto usual).

**4. Transformar `MainActivity` em host**

1. Sem Bottom Nav, `activity_main.xml` pode ser só o host (mantenha um id na raiz se ainda usar insets em `R.id.main`):

   ```xml
   <androidx.fragment.app.FragmentContainerView xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       android:id="@+id/nav_host"
       android:name="androidx.navigation.fragment.NavHostFragment"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       app:defaultNavHost="true"
       app:navGraph="@navigation/nav_graph" />
   ```

2. Crie `res/navigation/nav_graph.xml` com destinos: `counterFragment`, `historyFragment`, `settingsFragment`. O `android:id` de cada destino e o `android:name` da classe do Fragment precisam bater com o código.

3. `MainActivity` infla o host. Pegue o `NavController` pelo `NavHostFragment` (não chame `findNavController()` cedo demais na Activity):

   ```kotlin
   val navHost = supportFragmentManager
       .findFragmentById(R.id.nav_host) as NavHostFragment
   val navController = navHost.navController
   ```

**5. Bottom Navigation (opcional mas recomendado)**

O `FragmentContainerView` `match_parent` **sozinho** não deixa espaço para a barra. Precisa de um pai e altura `0dp` (constraint) ou `layout_weight`:

```xml
<androidx.constraintlayout.widget.ConstraintLayout ...
    android:id="@+id/main">

    <androidx.fragment.app.FragmentContainerView
        android:id="@+id/nav_host"
        android:name="androidx.navigation.fragment.NavHostFragment"
        android:layout_width="0dp"
        android:layout_height="0dp"
        app:defaultNavHost="true"
        app:navGraph="@navigation/nav_graph"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintBottom_toTopOf="@id/bottom_nav"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <com.google.android.material.bottomnavigation.BottomNavigationView
        android:id="@+id/bottom_nav"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        app:menu="@menu/menu_bottom_nav"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />
</androidx.constraintlayout.widget.ConstraintLayout>
```

Crie `res/menu/menu_bottom_nav.xml` com 3 itens cujos **ids são os mesmos** dos destinos no `nav_graph`.

Conecte:

```kotlin
binding.bottomNav.setupWithNavController(navController)
```

(`androidx.navigation.ui.setupWithNavController` — a classe `NavigationUI` também existe, mas a extension é o uso usual em Kotlin.)

Padding de system bars (edge-to-edge): aplique no `@id/main` (ou na Bottom Nav), para a barra não ficar sob a navegação do sistema.

**6. Validar**

- App abre na tela do contador e incrementa/decrementa normalmente.
- Navegação entre abas funciona.
- Gire a tela — por enquanto o contador **pode resetar** (ViewModel corrige isso na Fase C).

**Leituras**
- [Fragments](https://developer.android.com/guide/fragments)
- [Create a fragment](https://developer.android.com/guide/fragments/create)
- [Fragment lifecycle](https://developer.android.com/guide/fragments/lifecycle)
- [Communicate with fragments](https://developer.android.com/guide/fragments/communicate)
- [Get started with the Navigation Component](https://developer.android.com/guide/navigation/get-started)
- [Navigate between destinations](https://developer.android.com/guide/navigation/navigate)
- [Bottom navigation](https://developer.android.com/guide/navigation/ui/bottom-nav)
- [FragmentContainerView](https://developer.android.com/reference/androidx/fragment/app/FragmentContainerView)
- Codelab: [Navigation](https://developer.android.com/codelabs/android-navigation)
- Codelab: [Fragments](https://developer.android.com/codelabs/basic-android-kotlin-training-fragments-adapter) *(treinamento clássico com Views)*

---

### Fase C — Estado e ciclo de vida (ViewModel) (3–4 dias)

**Objetivo:** contador sobrevive a rotação de tela.

| Feature | Tecnologia |
|---------|------------|
| Estado do contador sobrevive rotação | `ViewModel` (sobrevive à recriação da UI; **não** sobrevive a processo morto — isso é Fase D) |
| UI reativa | `LiveData` ou `StateFlow`, observados com `viewLifecycleOwner` no Fragment |
| Lógica fora do Fragment | `CounterViewModel` no escopo do Fragment (ou do grafo de navegação), não um objeto global “por acidente” |

**Refatoração**
- Remover `private var contador` do Fragment
- Fragment observa `viewModel.counter` e atualiza `TextView`
- Cliques chamam `viewModel.increment()` / `decrement()`

**Dependência**
- `androidx.lifecycle:lifecycle-viewmodel-ktx`

**Extra**
- [ ] Exibir mensagem com `Snackbar` ao atingir limite máximo/mínimo

**Leituras**
- [ViewModel overview](https://developer.android.com/topic/libraries/architecture/viewmodel)
- [Guide to app architecture](https://developer.android.com/topic/architecture)
- [UI layer](https://developer.android.com/topic/architecture/ui-layer)
- [LiveData overview](https://developer.android.com/topic/libraries/architecture/livedata)
- [Kotlin flows on Android](https://developer.android.com/kotlin/flow) *(alternativa moderna ao LiveData)*
- [Snackbar](https://developer.android.com/reference/com/google/android/material/snackbar/Snackbar)
- Codelab: [ViewModel and LiveData](https://developer.android.com/codelabs/android-lifecycles)
- Curso: [Android Basics — ViewModel](https://developer.android.com/courses/pathways/android-basics-kotlin-unit-3-pathway-3)

---

### Fase D — Persistência local (2–3 dias)

**Objetivo:** valor não se perde ao fechar o app.

| Opção | Quando usar |
|-------|-------------|
| `SharedPreferences` | valor simples (contador atual) — **comece aqui** |
| DataStore Preferences | substituto moderno de SharedPreferences |
| Room | histórico com muitas entradas (Fase E) |

**Features**
- [ ] Salvar contador ao pausar app / a cada alteração
- [ ] Restaurar valor no `ViewModel` ao iniciar
- [ ] Settings: “Resetar ao abrir app” (toggle)

**Leituras**
- [Save key-value data (SharedPreferences)](https://developer.android.com/training/data-storage/shared-preferences)
- [DataStore](https://developer.android.com/topic/libraries/architecture/datastore)
- [Preferences DataStore](https://developer.android.com/topic/libraries/architecture/datastore#preferences-datastore)
- [Migrate from SharedPreferences to DataStore](https://developer.android.com/codelabs/android-preferences-datastore)
- [App architecture — data layer](https://developer.android.com/topic/architecture/data-layer)
- Codelab: [DataStore](https://developer.android.com/codelabs/android-preferences-datastore)

---

### Fase E — Histórico e listas (4–6 dias)

**Objetivo:** `RecyclerView` + modelo de dados.

**Features**
- Cada incremento/decremento gera entrada no histórico (valor + timestamp)
- `HistoryFragment` com `RecyclerView`
- Layout de item: `item_history_entry.xml`
- Limpar histórico (menu ou botão)

**Tecnologias**
- `RecyclerView` + `ListAdapter` + `DiffUtil`
- Room (opcional, recomendado): `HistoryEntry` entity + DAO

**Layouts XML novos**
- `fragment_history.xml`
- `item_history_entry.xml`

**Leituras**
- [Create dynamic lists with RecyclerView](https://developer.android.com/develop/ui/views/layout/recyclerview)
- [Create a list with RecyclerView](https://developer.android.com/guide/topics/ui/layout/recyclerview)
- [ListAdapter](https://developer.android.com/reference/androidx/recyclerview/widget/ListAdapter)
- [DiffUtil](https://developer.android.com/reference/androidx/recyclerview/widget/DiffUtil)
- [Save data in a local database using Room](https://developer.android.com/training/data-storage/room)
- [Room with a View (codelab)](https://developer.android.com/codelabs/android-room-with-a-view-kotlin)
- Codelab: [RecyclerView](https://developer.android.com/codelabs/android-training-create-recycler-view)
- Curso: [Android Basics — Lists](https://developer.android.com/courses/pathways/android-basics-kotlin-unit-2-pathway-3)

---

### Fase F — Configurações avançadas (2–3 dias)

**Objetivo:** interação rica em formulários XML.

**Features em `SettingsFragment`**
- Passo customizado (+5, +10…) — `Slider` ou `TextInputEditText`
- Limites min/max — validação
- Tema claro/escuro/sistema — `AppCompatDelegate`
- Vibrar ao incrementar — permissão + `HapticFeedback`

**Componentes XML úteis**
- `TextInputLayout` + `TextInputEditText`
- `SwitchMaterial`
- `Slider`

**Leituras**
- [Text fields (Material)](https://github.com/material-components/material-components-android/blob/master/docs/components/TextField.md)
- [Switch (Material)](https://github.com/material-components/material-components-android/blob/master/docs/components/Switch.md)
- [Slider (Material)](https://github.com/material-components/material-components-android/blob/master/docs/components/Slider.md)
- [AppCompatDelegate — night mode](https://developer.android.com/reference/androidx/appcompat/app/AppCompatDelegate#setDefaultNightMode(int))
- [Dark theme](https://developer.android.com/develop/ui/views/theming/darktheme)
- [Haptic feedback](https://developer.android.com/reference/android/view/View#performHapticFeedback(int))
- [Vibrate permission / VibrationEffect](https://developer.android.com/develop/ui/views/touch-and-input/haptics/haptics-principles)
- [Preference library (opcional, para tela de settings padrão)](https://developer.android.com/guide/topics/ui/settings)

---

### Fase G — Qualidade e testes (2–4 dias)

- [ ] Testes unitários do `ViewModel` (JUnit)
- [ ] Testes de UI com Espresso (clicar incrementar, ver texto “1”)
- [ ] Teste de rotação com Espresso (valor preservado)
- [ ] Acessibilidade: `contentDescription` nos botões

**Leituras**
- [Test apps on Android](https://developer.android.com/training/testing)
- [Fundamentals of testing](https://developer.android.com/training/testing/fundamentals)
- [Local unit tests (JUnit)](https://developer.android.com/training/testing/local-tests)
- [Espresso basics](https://developer.android.com/training/testing/espresso/basics)
- [Test UI for a single app (Espresso)](https://developer.android.com/training/testing/espresso)
- [Test ViewModels](https://developer.android.com/topic/libraries/architecture/viewmodel/viewmodel-testing-ktx)
- [Accessibility testing](https://developer.android.com/guide/topics/ui/accessibility/testing)
- Codelab: [Testing](https://developer.android.com/codelabs/advanced-android-kotlin-training-testing-basics)

---

### Fase H — Opcional: Compose ou widgets (exploração)

Escolha **um** caminho quando as fases A–G estiverem confortáveis:

| Caminho | Projeto |
|---------|---------|
| Jetpack Compose | Reescrever `CounterFragment` em `@Composable` |
| App Widget | Contador na home screen |
| Notificação persistente | Contador rápido na barra de status |

**Leituras**
- **Compose:** [Get started with Jetpack Compose](https://developer.android.com/develop/ui/compose/documentation) · [Compose pathway](https://developer.android.com/courses/pathways/compose) · [Interop with Views](https://developer.android.com/develop/ui/compose/migrate/interoperability-apis)
- **App Widget:** [App widgets overview](https://developer.android.com/develop/ui/views/appwidgets/overview) · [Create a simple widget](https://developer.android.com/develop/ui/views/appwidgets)
- **Notificações:** [Create a notification](https://developer.android.com/develop/ui/views/notifications/build-notification) · [Notification channels](https://developer.android.com/develop/ui/views/notifications/channels)

---

## Mapa de telas (visão alvo)

```
┌─────────────────────────────────────┐
│  AppContador          [Toolbar]     │
├─────────────────────────────────────┤
│                                     │
│         ┌───────────────┐           │
│         │      42       │  Card     │
│         └───────────────┘           │
│                                     │
│   [ − ]    [ Zerar ]    [ + ]       │
│                                     │
├─────────────────────────────────────┤
│  Contador  │  Histórico  │  Ajustes  │  ← Bottom Nav
└─────────────────────────────────────┘
```

---

## Estrutura de pacotes sugerida (após Fase B)

```
com.example.appcontador/
├── MainActivity.kt
├── ui/
│   ├── counter/
│   │   ├── CounterFragment.kt
│   │   └── CounterViewModel.kt      (Fase C)
│   ├── history/
│   │   ├── HistoryFragment.kt
│   │   └── HistoryAdapter.kt        (Fase E)
│   └── settings/
│       └── SettingsFragment.kt
├── data/
│   ├── CounterRepository.kt         (Fase D)
│   └── local/ ...                   (Fase E)
└── model/
    └── HistoryEntry.kt
```

Manter layouts em `res/layout/` com prefixos claros:
- `activity_*.xml`
- `fragment_*.xml`
- `layout_*.xml` (peças reutilizáveis com `<include>`)
- `item_*.xml`

---

## Ordem de implementação recomendada

| Semana | Foco | Resultado |
|--------|------|-----------|
| 1 | Fases 1–3 XML (já feitas) + Fase 4/A | Material, Card, botão Zerar |
| 2 | Fase B | 3 fragments + Navigation Component |
| 3 | Fase C + D | ViewModel + persistência |
| 4 | Fase E | Histórico com RecyclerView |
| 5 | Fase F + G | Settings + testes |

Ajuste o ritmo ao seu tempo. **RecyclerView** pede um `item_*.xml` estável antes da lista. **ViewModel** pode viver na Activity; neste plano ele entra depois do Fragment só para o estado já nascer na tela certa (o Fragment), não porque o Android exija essa ordem.

---

## Índice rápido de recursos (por tema)

Use esta tabela quando quiser pular direto para um assunto, sem seguir a ordem das fases.

| Tema | Comece por aqui | Aprofunde com |
|------|-----------------|---------------|
| Layout XML | [Declaring a layout](https://developer.android.com/develop/ui/views/layout/declaring-layout) | [Android Basics with Views](https://developer.android.com/courses/android-basics-kotlin/course) |
| ConstraintLayout | [Guia oficial](https://developer.android.com/develop/ui/views/layout/constraint-layout) | [Codelab ConstraintLayout](https://developer.android.com/codelabs/constraint-layout) |
| Recursos (`res/`) | [Providing resources](https://developer.android.com/guide/topics/resources/providing-resources) | [String / dimen / color](https://developer.android.com/guide/topics/resources/more-resources) |
| Material Design | [Look and feel](https://developer.android.com/develop/ui/views/theming/look-and-feel) | [Material Components docs](https://github.com/material-components/material-components-android) |
| View Binding | [View Binding](https://developer.android.com/topic/libraries/view-binding) | — |
| Fragments | [Fragments guide](https://developer.android.com/guide/fragments) | [Codelab Navigation](https://developer.android.com/codelabs/android-navigation) |
| Navigation | [Get started](https://developer.android.com/guide/navigation/get-started) | [Bottom nav](https://developer.android.com/guide/navigation/ui/bottom-nav) |
| ViewModel / estado | [ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel) | [Architecture guide](https://developer.android.com/topic/architecture) |
| Persistência | [SharedPreferences](https://developer.android.com/training/data-storage/shared-preferences) | [DataStore](https://developer.android.com/topic/libraries/architecture/datastore) |
| Listas | [RecyclerView](https://developer.android.com/develop/ui/views/layout/recyclerview) | [Room + View](https://developer.android.com/codelabs/android-room-with-a-view-kotlin) |
| Testes | [Testing overview](https://developer.android.com/training/testing) | [Espresso](https://developer.android.com/training/testing/espresso) |
| Compose (depois) | [Compose docs](https://developer.android.com/develop/ui/compose/documentation) | [Compose pathway](https://developer.android.com/courses/pathways/compose) |

**Cursos longos (trilha completa do Google):**
1. [Android Basics with Compose](https://developer.android.com/courses/android-basics-compose/course) — caminho oficial atual (Compose)
2. [Android Basics with Views (Kotlin)](https://developer.android.com/courses/android-basics-kotlin/course) — alinhado ao que você está fazendo agora (XML + Views)
3. [Jetpack Compose for Android Developers](https://developer.android.com/courses/jetpack-compose/course) — quando migrar

---

## Próximo passo imediato (sugestão concreta)

Fases 1–3 de layout já estão no código. O próximo bloco com impacto visível:

1. **Fase 4** — Card no `layout_counter_display.xml` (não no `<include>`); trocar `@color/black` por `?attr/colorOnSurface`; `MaterialButton` explícito só se for usar `app:icon`
2. **Fase A** — botão Zerar (cadeia de 3 ou linha extra; a Guideline de 50% não serve para 3 botões) e `atualizarUi()` com uma regra só (mínimo 0 **ou** negativo)
3. **Fase 5** — `layout-land/` dos **includes**, não uma cópia cega de `activity_main.xml`
4. Só então **Fase B** (Fragment), reusando os mesmos `<include>`

---

*Documento gerado para o projeto App Contador — atualize este arquivo marcando `[x]` conforme for concluindo cada item.*

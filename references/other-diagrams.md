# Other Mermaid Diagram Types

Complete reference for Gantt, Pie, Git Graph, Mindmap, Timeline, and other diagram types.

## Gantt Chart

### Basic Syntax

```mermaid
gantt
    title Project Schedule
    dateFormat YYYY-MM-DD

    section Planning
        Requirements    :a1, 2024-01-01, 30d
        Design          :a2, after a1, 20d

    section Development
        Implementation  :b1, after a2, 45d
        Testing         :b2, after b1, 15d

    section Deployment
        Release         :c1, after b2, 5d
```

### Date Formats

| Format | Example |
|--------|---------|
| `YYYY-MM-DD` | 2024-01-15 |
| `DD-MM-YYYY` | 15-01-2024 |
| `YYYY-MM-DDTHH:mm` | 2024-01-15T09:00 |

### Task Status

```mermaid
gantt
    dateFormat YYYY-MM-DD

    Completed task    :done, task1, 2024-01-01, 10d
    Active task       :active, task2, after task1, 10d
    Future task       :task3, after task2, 10d
    Critical task     :crit, task4, after task3, 5d
    Milestone         :milestone, m1, 2024-02-15, 0d
```

### Task Dependencies

```mermaid
gantt
    dateFormat YYYY-MM-DD

    Task A :a, 2024-01-01, 10d
    Task B :b, after a, 5d
    Task C :c, after a b, 7d
```

### Excluding Weekends

```mermaid
gantt
    dateFormat YYYY-MM-DD
    excludes weekends

    Task :2024-01-01, 14d
```

### Custom Weekend Days (v11)

```mermaid
gantt
    dateFormat YYYY-MM-DD
    excludes friday, saturday

    Task :2024-01-01, 14d
```

---

## Pie Chart

### Basic Syntax

```mermaid
pie
    title Browser Market Share
    "Chrome" : 65
    "Safari" : 19
    "Firefox" : 10
    "Edge" : 4
    "Other" : 2
```

### With showData

```mermaid
pie showData
    title Distribution
    "Category A" : 40
    "Category B" : 35
    "Category C" : 25
```

### Configuration

```mermaid
%%{init: {"pie": {"textPosition": 0.5}}}%%
pie
    title Sales by Region
    "North" : 30
    "South" : 25
    "East" : 25
    "West" : 20
```

---

## Git Graph

### Basic Syntax

```mermaid
gitGraph
    commit
    commit
    branch develop
    checkout develop
    commit
    commit
    checkout main
    merge develop
    commit
```

### With Commit IDs and Messages

```mermaid
gitGraph
    commit id: "initial"
    commit id: "feat-1" type: HIGHLIGHT
    branch feature
    commit id: "wip"
    commit id: "done"
    checkout main
    merge feature id: "merge-feature" tag: "v1.0.0"
```

### Commit Types

```mermaid
gitGraph
    commit type: NORMAL
    commit type: HIGHLIGHT
    commit type: REVERSE
```

### Branch Order

```mermaid
%%{init: {"gitGraph": {"mainBranchOrder": 2}}}%%
gitGraph
    commit
    branch develop order: 1
    commit
    branch feature order: 3
    commit
```

### Bottom-to-Top (v11)

```mermaid
%%{init: {"gitGraph": {"mainBranchOrder": 0}}}%%
gitGraph TB:
    commit
    branch develop
    commit
    checkout main
    merge develop
```

### Cherry-Pick

```mermaid
gitGraph
    commit id: "A"
    branch develop
    commit id: "B"
    commit id: "C"
    checkout main
    cherry-pick id: "C"
```

---

## Mindmap

### Basic Syntax

```mermaid
mindmap
    root((Central Topic))
        Topic A
            Subtopic A1
            Subtopic A2
        Topic B
            Subtopic B1
        Topic C
```

### Node Shapes

```mermaid
mindmap
    root((Circle Root))
        Square[Square]
        Rounded(Rounded)
        Bang))Bang((
        Cloud)Cloud(
        Hexagon{{Hexagon}}
```

### Icons (v11)

```mermaid
mindmap
    root((Project))
        ::icon(fa fa-book)
        Planning
        ::icon(fa fa-code)
        Development
        ::icon(fa fa-rocket)
        Deployment
```

---

## Timeline

### Basic Syntax

```mermaid
timeline
    title Company History
    2020 : Founded
         : First product launched
    2021 : Series A funding
         : Team expanded to 50
    2022 : International expansion
    2023 : IPO
```

### Sections

```mermaid
timeline
    title Product Roadmap
    section Q1
        January : Feature A
        February : Feature B
        March : Beta release
    section Q2
        April : Public launch
        May : Mobile app
        June : API v2
```

### With Hashtags and Semicolons (v11)

```mermaid
timeline
    title Social Media#59; Growth
    2020 : Launch #startup
    2021 : 1M users #milestone
    2022 : Viral moment #trending
```

---

## Quadrant Chart

### Basic Syntax

```mermaid
quadrantChart
    title Technology Assessment
    x-axis Low Effort --> High Effort
    y-axis Low Impact --> High Impact
    quadrant-1 Quick Wins
    quadrant-2 Major Projects
    quadrant-3 Fill-ins
    quadrant-4 Thankless Tasks

    Campaign A: [0.3, 0.6]
    Campaign B: [0.45, 0.23]
    Campaign C: [0.57, 0.69]
    Campaign D: [0.78, 0.34]
```

### Point Styling (v11)

```mermaid
quadrantChart
    Campaign A:::important: [0.3, 0.6]
    Campaign B:::warning: [0.45, 0.23]
```

---

## XY Chart (v11)

### Bar Chart

```mermaid
xychart-beta
    title "Sales Revenue"
    x-axis [Jan, Feb, Mar, Apr, May]
    y-axis "Revenue (K)" 0 --> 100
    bar [50, 60, 75, 80, 95]
```

### Line Chart

```mermaid
xychart-beta
    title "Stock Price"
    x-axis [Mon, Tue, Wed, Thu, Fri]
    y-axis "Price ($)" 100 --> 150
    line [102, 130, 118, 140, 145]
```

### Combined

```mermaid
xychart-beta
    title "Sales vs Target"
    x-axis [Q1, Q2, Q3, Q4]
    y-axis "Amount (M)" 0 --> 50
    bar [20, 25, 30, 40]
    line [25, 28, 32, 38]
```

---

## Block Diagram (v11)

### Basic Syntax

```mermaid
block-beta
    columns 3

    A["Frontend"]:1
    B["API Gateway"]:1
    C["Backend"]:1

    A --> B --> C
```

### Complex Layout

```mermaid
block-beta
    columns 4

    block:group1:2
        A["Service A"]
        B["Service B"]
    end

    block:group2:2
        C["Service C"]
        D["Service D"]
    end
```

---

## Sankey Diagram (v11)

### Basic Syntax

```mermaid
sankey-beta

Source A,Target X,100
Source A,Target Y,50
Source B,Target Y,75
Source B,Target Z,25
```

---

## Packet Diagram (v11)

### Basic Syntax

```mermaid
packet-beta
    0-15: "Header"
    16-31: "Payload Length"
    32-47: "Sequence Number"
    48-63: "Data"
```

---

## Architecture Diagram (v11)

### Basic Syntax

```mermaid
architecture-beta
    group api(cloud)[API]

    service db(database)[Database] in api
    service disk1(disk)[Storage] in api
    service server(server)[Server] in api

    db:L -- R:server
    disk1:T -- B:server
```

---

## Common Configuration Options

### Theme Selection

```mermaid
%%{init: {"theme": "forest"}}%%
```

Available themes: `default`, `forest`, `dark`, `neutral`, `base`

### Font and Size

```mermaid
%%{init: {
    "themeVariables": {
        "fontSize": "16px",
        "fontFamily": "Arial"
    }
}}%%
```

### Diagram-Specific Config

```mermaid
%%{init: {
    "gantt": {
        "titleTopMargin": 25,
        "barHeight": 20,
        "barGap": 4
    }
}}%%
```

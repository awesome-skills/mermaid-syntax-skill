# Flowchart Examples

## Example 1: CI/CD Pipeline

```mermaid
flowchart LR
    subgraph Build["Build Stage"]
        A[Checkout] --> B[Install Deps]
        B --> C[Compile]
        C --> D[Unit Tests]
    end

    subgraph Test["Test Stage"]
        E[Integration Tests]
        F[E2E Tests]
    end

    subgraph Deploy["Deploy Stage"]
        G{Environment?}
        H[Deploy Staging]
        I[Deploy Production]
    end

    D --> E
    D --> F
    E --> G
    F --> G
    G -->|staging| H
    G -->|production| I
```

## Example 2: Authentication Flow

```mermaid
flowchart TD
    Start([Start]) --> Input[/"Enter Credentials"/]
    Input --> Validate{Valid Format?}

    Validate -->|No| Error1["Invalid Format"]
    Error1 --> Input

    Validate -->|Yes| Check[(Check Database)]
    Check --> Auth{Authenticated?}

    Auth -->|No| Error2["Invalid Credentials"]
    Error2 --> Attempt{Attempts < 3?}
    Attempt -->|Yes| Input
    Attempt -->|No| Locked["Account Locked"]
    Locked --> End([End])

    Auth -->|Yes| Token["Generate Token"]
    Token --> Success["Login Success"]
    Success --> End
```

## Example 3: Error Handling Pattern

```mermaid
flowchart TB
    subgraph Try["Try Block"]
        A[Execute Operation]
    end

    subgraph Catch["Catch Block"]
        B{Error Type?}
        C["Handle Network Error"]
        D["Handle Validation Error"]
        E["Handle Unknown Error"]
    end

    subgraph Finally["Finally Block"]
        F[Cleanup Resources]
    end

    A -->|success| F
    A -->|error| B
    B -->|NetworkError| C
    B -->|ValidationError| D
    B -->|Unknown| E
    C --> F
    D --> F
    E --> F
```

## Example 4: Decision Tree with Styling

```mermaid
flowchart TD
    classDef decision fill:#ffd700,stroke:#333
    classDef action fill:#90ee90,stroke:#333
    classDef terminal fill:#ff6b6b,stroke:#333

    Start([Start]):::terminal --> Q1{Budget > 1000?}:::decision
    Q1 -->|Yes| Q2{Need Speed?}:::decision
    Q1 -->|No| Budget[Consider Budget Options]:::action

    Q2 -->|Yes| Premium[Premium Plan]:::action
    Q2 -->|No| Standard[Standard Plan]:::action

    Budget --> End([End]):::terminal
    Premium --> End
    Standard --> End
```

## Example 5: Special Characters Handled Correctly

```mermaid
flowchart LR
    A["Step 1: Initialize"]
    B["Check (optional)"]
    C["Process 'data'"]
    D["Output: result"]
    E["Status #59; Code"]

    A --> B --> C --> D --> E
```

## Example 6: Subgraph with Links

```mermaid
flowchart TB
    subgraph Frontend["Frontend (React)"]
        UI[Components]
        State[Redux Store]
    end

    subgraph Backend["Backend (Node.js)"]
        API[REST API]
        Auth[Auth Middleware]
    end

    subgraph Database["Database (PostgreSQL)"]
        DB[(Main DB)]
        Cache[(Redis Cache)]
    end

    UI --> State
    State --> API
    API --> Auth
    Auth --> DB
    Auth --> Cache
    Cache --> DB
```

## Example 7: Node Shapes Showcase

```mermaid
flowchart LR
    A[Rectangle] --> B(Rounded)
    B --> C([Stadium])
    C --> D[[Subroutine]]
    D --> E[(Database)]
    E --> F((Circle))
    F --> G{Diamond}
    G --> H{{Hexagon}}
    H --> I>Asymmetric]
```

## Example 8: Edge Types Showcase

```mermaid
flowchart LR
    A -->|Arrow| B
    B ---|Line| C
    C -.-|Dotted| D
    D ==>|Thick| E
    E -.->|Dotted Arrow| F
    F --o|Circle End| G
    G --x|Cross End| H
```

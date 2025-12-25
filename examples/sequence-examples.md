# Sequence Diagram Examples

## Example 1: REST API Request

```mermaid
sequenceDiagram
    participant C as Client
    participant LB as Load Balancer
    participant S as Server
    participant DB as Database

    C->>+LB: GET /api/users
    LB->>+S: Forward request
    S->>+DB: SELECT * FROM users
    DB-->>-S: User records
    S-->>-LB: JSON response
    LB-->>-C: 200 OK
```

## Example 2: OAuth2 Authorization Code Flow

```mermaid
sequenceDiagram
    participant U as User
    participant A as App
    participant AS as Auth Server
    participant RS as Resource Server

    U->>A: Click Login
    A->>AS: Authorization Request
    AS->>U: Login Page
    U->>AS: Enter Credentials
    AS->>A: Authorization Code
    A->>AS: Exchange Code for Token
    AS->>A: Access Token + Refresh Token
    A->>RS: API Request + Access Token
    RS->>AS: Validate Token
    AS->>RS: Token Valid
    RS->>A: Protected Resource
    A->>U: Display Data
```

## Example 3: Microservices Communication

```mermaid
sequenceDiagram
    participant G as Gateway
    participant O as Order Service
    participant I as Inventory Service
    participant P as Payment Service
    participant N as Notification Service

    G->>+O: Create Order

    par Check Inventory
        O->>+I: Check Stock
        I-->>-O: Stock Available
    and Process Payment
        O->>+P: Charge Customer
        P-->>-O: Payment Success
    end

    O->>N: Send Confirmation
    Note over N: Async notification
    N-)O: Ack

    O-->>-G: Order Created
```

## Example 4: Error Handling with Alt

```mermaid
sequenceDiagram
    participant C as Client
    participant S as Server
    participant DB as Database

    C->>S: Request Data
    S->>DB: Query

    alt Success
        DB-->>S: Data
        S-->>C: 200 OK with data
    else Not Found
        DB-->>S: Empty Result
        S-->>C: 404 Not Found
    else Database Error
        DB-->>S: Connection Error
        S-->>C: 503 Service Unavailable
    end
```

## Example 5: Retry Pattern with Loop

```mermaid
sequenceDiagram
    participant C as Client
    participant S as Server

    C->>S: Initial Request

    loop Max 3 Retries
        alt Success
            S-->>C: 200 OK
        else Timeout
            Note over C: Wait with backoff
            C->>S: Retry
        else Server Error
            S-->>C: 500 Error
            Note over C: Wait with backoff
            C->>S: Retry
        end
    end

    opt All Retries Failed
        Note over C: Log error and notify
    end
```

## Example 6: WebSocket Communication

```mermaid
sequenceDiagram
    participant C as Client
    participant S as WebSocket Server

    C->>S: Connect (HTTP Upgrade)
    S-->>C: 101 Switching Protocols

    Note over C,S: WebSocket connection established

    par Bidirectional Messages
        C-)S: Subscribe to channel
        S-)C: Subscription confirmed
    and
        loop Real-time Updates
            S-)C: Push notification
            C-)S: Acknowledgment
        end
    end

    C->>S: Close connection
    S-->>C: Connection closed
```

## Example 7: Activation and Nested Calls

```mermaid
sequenceDiagram
    participant U as User
    participant C as Controller
    participant S as Service
    participant R as Repository

    U->>+C: HTTP Request
    C->>+S: Process
    S->>+R: Find
    R-->>-S: Entity
    S->>S: Transform
    S-->>-C: DTO
    C-->>-U: HTTP Response
```

## Example 8: Box Grouping with Colors

```mermaid
sequenceDiagram
    box rgba(135, 206, 235, 0.3) Frontend
        participant U as User
        participant UI as Web App
    end

    box rgba(144, 238, 144, 0.3) Backend
        participant API as API Gateway
        participant SVC as Service
    end

    box rgba(255, 182, 193, 0.3) Data Layer
        participant DB as Database
        participant Cache as Redis
    end

    U->>UI: Click Button
    UI->>API: API Call
    API->>Cache: Check Cache

    alt Cache Hit
        Cache-->>API: Cached Data
    else Cache Miss
        API->>SVC: Process
        SVC->>DB: Query
        DB-->>SVC: Result
        SVC-->>API: Data
        API->>Cache: Update Cache
    end

    API-->>UI: Response
    UI-->>U: Display Result
```

## Example 9: Critical Section

```mermaid
sequenceDiagram
    participant A as Application
    participant L as Lock Service
    participant DB as Database

    A->>L: Acquire Lock

    critical Holding Lock
        L-->>A: Lock Acquired
        A->>DB: Read Data
        DB-->>A: Current Value
        A->>A: Modify
        A->>DB: Write Data
        DB-->>A: Success
        A->>L: Release Lock
    option Lock Timeout
        L-->>A: Lock Expired
        A->>A: Rollback Changes
    option Lock Contention
        L-->>A: Lock Denied
        A->>A: Wait and Retry
    end
```

## Example 10: Special Characters Escaped

```mermaid
sequenceDiagram
    participant A as "Client (Browser)"
    participant B as "Server: API"

    Note over A: User clicks #59; action triggered
    A->>B: GET /api/data?key=value#59;other=123
    B-->>A: {"status": "ok", "data": "result"}
```

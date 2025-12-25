#!/bin/bash
# Mermaid Diagram Syntax Validator
# Checks for common syntax errors that break Mermaid diagrams
#
# Usage: ./validate-mermaid.sh <file.md>
# Or pipe content: echo "flowchart LR\n  A-->B" | ./validate-mermaid.sh

set -e

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

errors=0
warnings=0

# Read input from file or stdin
if [ -n "$1" ] && [ -f "$1" ]; then
    content=$(cat "$1")
    filename="$1"
else
    content=$(cat)
    filename="stdin"
fi

echo "Validating Mermaid syntax in: $filename"
echo "=========================================="

# Check 1: Lowercase "end" that's not quoted
if echo "$content" | grep -E '\b[Aa]-->\s*end\b' | grep -v '"end"' | grep -v "'end'" > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Bare 'end' word found (breaks diagrams)${NC}"
    echo "  Fix: Use \"end\" or End or [end]"
    ((errors++))
fi

# Check 2: Node starting with single 'o' or 'x' that could create edge
if echo "$content" | grep -E '---[ox][A-Z]' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Potential unintended circle/cross edge (---o or ---x pattern)${NC}"
    echo "  Fix: Add space before 'o' or 'x', or use full word IDs"
    ((warnings++))
fi

# Check 3: Unquoted special characters in node labels
if echo "$content" | grep -E '\[[^\]"]*[:;()@#]\s*[^\]]*\]' | grep -v '"\[' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Possible unquoted special characters in node labels${NC}"
    echo "  Fix: Wrap text with special chars in quotes: A[\"Text: here\"]"
    ((warnings++))
fi

# Check 4: Single % comment (should be %%)
if echo "$content" | grep -E '^\s*%[^%]' > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Single % comment found (must use %%)${NC}"
    echo "  Fix: Use %% for comments"
    ((errors++))
fi

# Check 5: Subgraph with <br/> not quoted
if echo "$content" | grep -E 'subgraph\s+[^"]*<br' > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Subgraph title with <br/> must be quoted${NC}"
    echo "  Fix: subgraph \"Title<br/>here\""
    ((errors++))
fi

# Check 6: Missing diagram type declaration
if ! echo "$content" | grep -E '^\s*(flowchart|sequenceDiagram|classDiagram|stateDiagram|erDiagram|gantt|pie|gitGraph|mindmap|timeline|quadrantChart|xychart-beta|block-beta|sankey-beta|packet-beta|architecture-beta)' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: No diagram type declaration found${NC}"
    echo "  Fix: Start with flowchart, sequenceDiagram, etc."
    ((warnings++))
fi

# Check 7: Semicolon in sequence diagram message (not escaped)
if echo "$content" | grep -E '->>.*:.*[^#];' | grep -v '#59;' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Possible unescaped semicolon in sequence message${NC}"
    echo "  Fix: Use #59; for literal semicolons"
    ((warnings++))
fi

# Summary
echo ""
echo "=========================================="
if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}✓ No issues found${NC}"
    exit 0
elif [ $errors -eq 0 ]; then
    echo -e "${YELLOW}⚠ $warnings warning(s) found${NC}"
    exit 0
else
    echo -e "${RED}✗ $errors error(s), $warnings warning(s) found${NC}"
    exit 1
fi

#!/bin/bash
# Mermaid Diagram Syntax Validator v1.2
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

# Check 1: Reserved words as node IDs (end, default, style, class, etc.)
reserved_words="end|default|style|linkStyle|classDef|class|call|href|click|interpolate"
if echo "$content" | grep -E "^\s*($reserved_words)\s*[\[\(\{]" > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Reserved word used as node ID${NC}"
    echo "  Reserved: end, default, style, linkStyle, classDef, class, call, href, click"
    echo "  Fix: Use safeId[\"reserved word\"] instead"
    ((errors++))
fi

# Check 2: Bare 'end' or 'default' in arrows
if echo "$content" | grep -E '-->\s*(end|default)\b' | grep -v '"' > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Bare reserved word in arrow target${NC}"
    echo "  Fix: Use nodeId[\"end\"] or nodeId[\"default\"]"
    ((errors++))
fi

# Check 3: Node starting with single 'o' or 'x' that could create edge
if echo "$content" | grep -E '---[ox][A-Z]' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Potential unintended circle/cross edge (---o or ---x pattern)${NC}"
    echo "  Fix: Add space before 'o' or 'x', or use full word IDs"
    ((warnings++))
fi

# Check 4: Unquoted special characters in node labels
if echo "$content" | grep -E '\[[^\]"]*[:;()@#]\s*[^\]]*\]' | grep -v '"\[' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Possible unquoted special characters in node labels${NC}"
    echo "  Fix: Wrap text with special chars in quotes: A[\"Text: here\"]"
    ((warnings++))
fi

# Check 5: Single % comment (should be %%)
if echo "$content" | grep -E '^\s*%[^%{]' > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Single % comment found (must use %%)${NC}"
    echo "  Fix: Use %% for comments"
    ((errors++))
fi

# Check 6: Subgraph with <br/> not quoted
if echo "$content" | grep -E 'subgraph\s+[^"]*<br' > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Subgraph title with <br/> must be quoted${NC}"
    echo "  Fix: subgraph \"Title<br/>here\""
    ((errors++))
fi

# Check 7: Missing diagram type declaration
if ! echo "$content" | grep -E '^\s*(flowchart|sequenceDiagram|classDiagram|stateDiagram|erDiagram|gantt|pie|gitGraph|mindmap|timeline|quadrantChart|xychart-beta|block-beta|sankey-beta|packet-beta|architecture-beta|graph)' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: No diagram type declaration found${NC}"
    echo "  Fix: Start with flowchart, sequenceDiagram, etc."
    ((warnings++))
fi

# Check 8: Semicolon in sequence diagram message (not escaped)
if echo "$content" | grep -E '->>.*:.*[^#];' | grep -v '#59;' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: Possible unescaped semicolon in sequence message${NC}"
    echo "  Fix: Use #59; for literal semicolons"
    ((warnings++))
fi

# Check 9: Frontmatter not on first line (check if --- appears but not at start)
first_line=$(echo "$content" | head -n1)
if echo "$content" | grep -E '^---$' > /dev/null 2>&1; then
    if [ "$first_line" != "---" ]; then
        echo -e "${RED}ERROR: Frontmatter --- must be on the very first line${NC}"
        echo "  Fix: Remove any whitespace or content before ---"
        ((errors++))
    fi
fi

# Check 10: Mindmap with < character (renders as &lt;)
if echo "$content" | grep -E '^mindmap' > /dev/null 2>&1; then
    if echo "$content" | grep -E '<[^/]' | grep -v '<br' > /dev/null 2>&1; then
        echo -e "${YELLOW}WARNING: Mindmap contains < character (may render as &lt;)${NC}"
        echo "  Fix: Use words like 'less than' instead of <"
        ((warnings++))
    fi
fi

# Check 11: stroke-dasharray without escaped comma
if echo "$content" | grep -E 'stroke-dasharray:\s*[0-9]+,[0-9]+' | grep -v '\\,' > /dev/null 2>&1; then
    echo -e "${YELLOW}WARNING: stroke-dasharray comma may need escaping${NC}"
    echo "  Fix: Use stroke-dasharray: 5\\,5"
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

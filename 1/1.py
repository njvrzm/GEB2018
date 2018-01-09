def transform(theorem):
    if theorem.endswith('I'):
        yield theorem + 'U'
    for place in range(len(theorem)):
        if place == 0 and theorem[place] == 'M':
            yield 'M' + theorem[1:] + theorem[1:]
        elif theorem[place:].startswith('III'):
            yield theorem[:place] + 'U' + theorem[place + 3:]
        elif theorem[place:].startswith('UU'):
            yield theorem[:place] + theorem[place + 2:]

def theorize(theorems):
    seen = set(theorems)

    for index, theorem in enumerate(theorems):
        yield theorem
        if theorem == 'MU':
            raise ArithmeticError("Impossible success")
        for newTheorem in transform(theorem):
            if newTheorem not in seen:
                seen.add(newTheorem)
                theorems.append(newTheorem)


if __name__ == '__main__':
    from signal import signal, SIGPIPE, SIG_DFL
    # Suppress "broken pipe" error
    signal(SIGPIPE, SIG_DFL)

    for theorem in theorize(['MI']):
        print(theorem)


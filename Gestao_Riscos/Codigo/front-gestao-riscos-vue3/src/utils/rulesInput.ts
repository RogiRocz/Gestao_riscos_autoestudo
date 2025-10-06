export const rules = {
    minimumSize: (word: string) => {
        return word.length < 3 ? 'A quantidade mínima é 3 caracteres': true;
    },
    email: (word: string) => {
        const regexEmail = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
        return word.match(regexEmail) ? true : 'Email inválido';
    },
    password: (word: string) => {
        return word.length < 8 ? 'A senha deve ter no mínimo 8 caracteres': true;
    }
};
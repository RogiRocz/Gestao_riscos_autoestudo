export default function (token: string) {
	if (!token) {
		return null;
	}

	const parts = token.split('.');
	if (parts.length != 3) {
		return null;
	}
	const payloadEncoded = parts[1];

	const payloadDecoded = atob(payloadEncoded);

	const payload = JSON.parse(payloadDecoded);

	return payload.exp;
}

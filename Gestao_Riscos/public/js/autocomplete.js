document.addEventListener('DOMContentLoaded', function() {
    var responsaveis = document.querySelectorAll('.autocomplete');
    var instancesResponsaveis = M.Autocomplete.init(responsaveis, {
        data: {
            "Gleydson Pinto": null,
            "João Pedro": null,
            "Germana Silva": null
        },
    });
    var riscos = document.querySelectorAll('.autocompleteRisco');
    var instancesRiscos = M.Autocomplete.init(riscos, {
        data: {
            "Ausência de infraestrutura e equipamentos necessários para a realização do curso": null,
            "Redução orçamentária dos recursos destinados à capacitação": null
        },
    });

});
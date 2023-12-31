#!"C:\xampp\perl\bin\perl.exe"
use CGI;
my $cgi = CGI->new;
print $cgi->header(-type => 'text/html', -charset => 'utf-8');
my $expresion = $cgi->param('expresion');
my $resultadoAImprimir;
sub evaluar_expresion {
    my $expresion = shift;
    return eval $expresion;
}
if ($expresion =~ /^([\d.]+)\s*([\+\-\*\/])\s*([\d.]+)$/) {
    my $operando1 = $1;
    my $operador = $2;
    my $operando2 = $3;
    my $resultado = evaluar_expresion($expresion);
    $resultadoAImprimir = "Resultado: $resultado\n";
} elsif ($expresion =~ /^\((.+)\)$/) {
    # La expresión está entre paréntesis
    my $expresion_sin_parentesis = $1;

    # Validar la expresión dentro de los paréntesis
    if ($expresion_sin_parentesis =~ /^([\d.]+)\s*([\+\-\*\/])\s*([\d.]+)$/) {
        my $resultado = evaluar_expresion($expresion_sin_parentesis);
        $resultadoAImprimir = "Resultado dentro de paréntesis: $resultado\n";
    } else {
        $resultadoAImprimir = "Expresión no válida dentro de paréntesis.\n";
    }
} else {
    $resultadoAImprimir = "Expresión no válida\n";
}
print <<EOF;
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/index.css">
    <title>Laboratorio 8</title>
</head>

<body>
    <div class="content">
        <h1>Calculadora con Perl</h1>
        <form action="codigo.pl">
            <div class="calculadora">
                <input type="text" name="expresion" placeholder="Ingrese la operacion a calcular">
                <button><span>Calcular</span></button>
                $resultadoAImprimir
            </div>
        </form>
        <p>Made by Skkippie</p>
    </div>
</body>

</html>
EOF
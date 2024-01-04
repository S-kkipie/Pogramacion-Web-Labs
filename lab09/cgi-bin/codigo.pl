#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use Text::CSV;

my $q = CGI->new;

# Obtener parámetros del formulario
my $nombre_universidad = $q->param('0');
my $periodo_licenciamento = $q->param('1');
my $departamento_local = $q->param('2');
my $denominacion_programa = $q->param('3');

# Nombre del archivo CSV
my $archivo_csv = 'Programas-de-Universidades.csv';

# Crear objeto CSV
my $csv = Text::CSV->new({ binary => 1, sep_char => '|' });

# Imprimir encabezado de la respuesta HTTP
print $q->header('text/html');

# Imprimir el inicio del HTML
print $q->start_html(-title => 'Resultados de la Búsqueda');

# Imprimir las líneas que cumplen con los criterios de búsqueda
print "<h2>Resultados de la búsqueda:</h2>";
print "<table border='1'>";
print "<tr><th>Nombre Universidad</th><th>Periodo Licenciamento</th><th>Departamento Local</th><th>Denominacion Programa</th></tr>";

open my $fh, '<', $archivo_csv or die "No se puede abrir el archivo '$archivo_csv': $!";
while (my $row = $csv->getline($fh)) {
    # Convertir a minúsculas y quitar tildes para la comparación
    my $nombre_universidad_lc = lc($row->[1]);
    my $periodo_licenciamento_lc = lc($row->[4]);
    my $departamento_local_lc = lc($row->[11]);
    my $denominacion_programa_lc = lc($row->[16]);

    if (
        ($nombre_universidad eq '' || $nombre_universidad_lc =~ /$nombre_universidad/i) &&
        ($periodo_licenciamento eq '' || $periodo_licenciamento_lc =~ /$periodo_licenciamento/i) &&
        ($departamento_local eq '' || $departamento_local_lc =~ /$departamento_local/i) &&
        ($denominacion_programa eq '' || $denominacion_programa_lc =~ /$denominacion_programa/i)
    ) {
        # Imprimir los resultados en forma de tabla
        print "<tr>";
        print "<td>", $row->[1], "</td>";
        print "<td>", $row->[4], "</td>";
        print "<td>", $row->[11], "</td>";
        print "<td>", $row->[16], "</td>";
        print "</tr>";
    }
}
close $fh;

# Imprimir el fin del HTML
print "</table>";
print $q->end_html;
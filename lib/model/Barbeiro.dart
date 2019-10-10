import 'HorarioMarcado.dart';
import 'Cidade.dart';
import 'Barbearia.dart';

class Barbeiro {
	 String id;
	 Barbearia barbearia;
	 Cidade cidade;
	 String nome;
	 String rg;
	 String cpf;
	 int telefone;
	 int celular;
	// URL
	 String foto;
	 DateTime dataNascimento;
	 DateTime cadastro;
	 DateTime alterado;
	 List<HorarioMarcado> horariosMarcados;
}
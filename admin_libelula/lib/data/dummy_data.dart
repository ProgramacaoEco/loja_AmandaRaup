import 'package:admin_newpedido/model/produto.dart';
import 'package:admin_newpedido/model/quantidade.dart';
import 'package:admin_newpedido/model/tamanho.dart';

final dummyTamanhos = [
  Tamanho(id: 0, tamanho: 'PP'),
  Tamanho(id: 1, tamanho: 'P'),
  Tamanho(id: 2, tamanho: 'M'),
  Tamanho(id: 3, tamanho: 'G'),
  Tamanho(id: 4, tamanho: 'XG'),
  
];

// final dummyQuantitys = [
//   Quantidade(
//     id: 0, 
//     quantidade: 5, 
//     id_produto: 0, 
//     id_tamanho: 0,
//     tamanho: "PP",
//     codigoProduto: 'AA123'
//     ),
//   Quantidade(
//     id: 1, 
//     quantidade: 2, 
//     id_produto: 0, 
//     id_tamanho: 1,
//     tamanho: "P",
//     codigoProduto: 'AA123'
//     ),
//   Quantidade(
//     id: 2, 
//     quantidade: 50, 
//     id_produto: 0, 
//     id_tamanho: 2,
//     tamanho: "M",
//     codigoProduto: 'AA123'
//     ),
//   Quantidade(
//     id: 3, 
//     quantidade: 21, 
//     id_produto: 1, 
//     id_tamanho: 0,
//     tamanho: "PP",
//     codigoProduto: 'BB12'
//     ),
//   Quantidade(
//     id: 4, 
//     quantidade: 7, 
//     id_produto: 1, 
//     id_tamanho: 1,
//     tamanho: "P",
//     codigoProduto: 'BB12'
//     ),
//   Quantidade(
//     id: 5, 
//     quantidade: 9, 
//     id_produto: 2, 
//     id_tamanho: 4,
//     tamanho: "XG",
//     codigoProduto: 'CC123'
//     ),
// ];

final dummyProducts = [
  Produto(
      id: 0,
      idCategoria: 1,
      descricaoProduto: 'Tênis Adidas',
      valor: 120.0,
      descricaoPagamento: '10x sem juros',
      destaque: 1,
      codigoProduto: 'AA123'),
  Produto(
      id: 1,
      idCategoria: 1,
      descricaoProduto: 'Tênis Nike',
      valor: 24.0,
      descricaoPagamento: '10x sem juros',
      destaque: 1,
      codigoProduto: 'NIKE123'),
  Produto(
      id: 2,
      idCategoria: 1,
      descricaoProduto: 'Tênis Polo',
      valor: 35.0,
      descricaoPagamento: '10x sem juros',
      destaque: 1,
      codigoProduto: 'POLOWE'),
  Produto(
      id: 3,
      idCategoria: 1,
      descricaoProduto: 'Tênis Fake',
      valor: 82.0,
      descricaoPagamento: '10x sem juros',
      destaque: 1,
      codigoProduto: 'FAKE98'),
];

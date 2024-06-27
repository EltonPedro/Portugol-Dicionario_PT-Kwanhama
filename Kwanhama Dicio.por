programa
{
	inclua biblioteca Tipos --> tp
	inclua biblioteca Mouse --> m
	inclua biblioteca Texto --> tx
	inclua biblioteca Arquivos --> a
	inclua biblioteca Util --> u
	inclua biblioteca Teclado --> tc
	inclua biblioteca Graficos --> gfx

	//<>

	cadeia PALAVRAS_PT[69],
		PALAVRAS_CH[69],
		upbotao[2] = {"Português", "Kwanhama"},
		ORGANIZAR_PALAVRAS[138],
		caminho_img = "change.png"
		

		inteiro img_change = gfx.redimensionar_imagem(gfx.carregar_imagem(caminho_img), 50, 41, verdadeiro),
			REFERENCIAIS[61],
			counter_Re = 0
	
	funcao MANIPULACAO_DAS_PALAVRAS_E_REFERENCIAIS( logico tradutor)
	{
		cadeia lerLinha = "", 
			caminho = "palavras.txt"//,
			//caminhoT = "refInd.txt"
			
		inteiro arquivo_pal = a.abrir_arquivo(caminho, 0),
			//arquivo_ref = a.abrir_arquivo(caminhoT, 1), 
			linha = -1
		
		se ( tradutor ) {

			
			 
		} senao {

			enquanto ( nao a.fim_arquivo(arquivo_pal)  )	{
				
				linha ++
			
				lerLinha = a.ler_linha(arquivo_pal)

				se ( lerLinha != "") {
				
					ORGANIZAR_PALAVRAS[linha] = tx.extrair_subtexto(lerLinha, 0, tx.posicao_texto("-", lerLinha, 0))
					ORGANIZAR_PALAVRAS[70+linha-1] = tx.extrair_subtexto(lerLinha, tx.posicao_texto("-", lerLinha, 0) + 1, tx.numero_caracteres(lerLinha))
				
				
				} senao {
					
					linha --
				}
						
			} a.fechar_arquivo(arquivo_pal)

			para ( inteiro i = 0 ; i <= 2 ; i ++ ) {

				se ( i == 0 ) {
				
					ORGANIZACAO_DAS_PALAVRAS( i, 67, 68)
				
				} senao se ( i == 1 ) {

					ORGANIZACAO_DAS_PALAVRAS( 69, 137, 138)
				 
				} senao {
				
					para ( inteiro x = 0 ; x < 69 ; x ++ ) {

						PALAVRAS_CH[x] = ORGANIZAR_PALAVRAS[x]

						PALAVRAS_PT[x] = ORGANIZAR_PALAVRAS[70+x-1]
					}
				}
			}		
		}
	}

	funcao ORGANIZACAO_DAS_PALAVRAS( inteiro min, inteiro med, inteiro max ) {
		
		inteiro c1 = 0, c2 = 0, CARACTER_DE_MAIOR_PRIORIDADE = 0
		cadeia temp = " "
		
		para ( inteiro a = min ; a < med ; a++ ) {
        	
            	para ( inteiro b = a + 1 ; b < max ; b ++ ) {
        	
            		se ( tx.numero_caracteres(ORGANIZAR_PALAVRAS[a]) > tx.numero_caracteres(ORGANIZAR_PALAVRAS[b]) ) {
        	
            			CARACTER_DE_MAIOR_PRIORIDADE = tx.numero_caracteres(ORGANIZAR_PALAVRAS[b])
            
        			} senao {
            
            			CARACTER_DE_MAIOR_PRIORIDADE = tx.numero_caracteres(ORGANIZAR_PALAVRAS[a])
        			}			
            	
                	para ( inteiro c = 0 ; c < CARACTER_DE_MAIOR_PRIORIDADE ; c ++ ) {

					para ( inteiro z = 65 ; z <= 90 ; z ++ ) {
        	
            				se ( tp.cadeia_para_caracter(tx.caixa_baixa(tp.caracter_para_cadeia(tx.obter_caracter(ORGANIZAR_PALAVRAS[a], c)))) == tp.cadeia_para_caracter(tx.caixa_baixa(tp.caracter_para_cadeia(tc.caracter_tecla(z)))) ) {
                
                				c1 = z
                					
            				} se ( tp.cadeia_para_caracter(tx.caixa_baixa(tp.caracter_para_cadeia(tx.obter_caracter(ORGANIZAR_PALAVRAS[b], c)))) == tp.cadeia_para_caracter(tx.caixa_baixa(tp.caracter_para_cadeia(tc.caracter_tecla(z)))) ) {
                
                				c2 = z
            				}
            
					}
                    
                    	se ( c1 < c2 ) {
                    	
                        	pare
                        
                    	} senao se ( c1 > c2 ) {
                    	
                        		temp = ORGANIZAR_PALAVRAS[a]
          				ORGANIZAR_PALAVRAS[a] = ORGANIZAR_PALAVRAS[b]
         	 				ORGANIZAR_PALAVRAS[b] = temp
                        
                        		pare
                        
                    	} senao se ( c1 == c2 e tx.numero_caracteres(ORGANIZAR_PALAVRAS[a]) > tx.numero_caracteres(ORGANIZAR_PALAVRAS[b]) ) {

                        		temp = ORGANIZAR_PALAVRAS[a]
          				ORGANIZAR_PALAVRAS[a] = ORGANIZAR_PALAVRAS[b]
         	 				ORGANIZAR_PALAVRAS[b] = temp
                    }
                } 
            }
        }		
	}

	funcao inicio()
	{ 
		// Informações da tela a ser criada
		gfx.iniciar_modo_grafico(verdadeiro) // Inicialização do modo gráfico
		gfx.definir_dimensoes_janela(1280, 720) // Tamanho da Janela
		gfx.definir_titulo_janela("Kwanhama Dicio - Trans") // Titulo da Janela

		//Variavéis Essenciais######
		inteiro lingua_padrao = 0, // Texto no botao de troca de lingua
			pv_bar = 60,
			c1_wl = 0,
			pv_wl = 25,
			pi_wl = 0,
			 y = 35
				
		logico v_trocar_lingua = falso, //Botao de troca de lingua
			teclado = falso, // Teclado ativou ou não
			CAPS_LOCK = falso, // CAPS LOCK do teclado ativo ou não
			main_pos = verdadeiro,
			tradutor = falso
			
		cadeia palavra_barra_pesquisa = "" // Exibir as palavras na barra de pesquisa 
			,pal_pesquisada = "",
			pal_tradutor = ""
				
		MANIPULACAO_DAS_PALAVRAS_E_REFERENCIAIS(tradutor)
		
		enquanto ( verdadeiro ) {
			
		//<>
		//	Cor de fundo da Janela
			gfx.definir_cor(gfx.criar_cor(233, 233, 233)) 
			gfx.limpar()		
			
			PARTE_ESTATICA( lingua_padrao, teclado, CAPS_LOCK, lingua_padrao)				

			se ( teclado ) {

				TECLADO( teclado, CAPS_LOCK, palavra_barra_pesquisa, 8, tradutor, pal_tradutor)
			}

			se ( tradutor == falso ) {
				
				FORMATACAO_TEXTO()

				se ( lingua_padrao == 0 ) {					
									
					gfx.desenhar_texto( 450, 165, pal_pesquisada)
					
					para ( inteiro i = 0 ; i < 69 ; i ++ ) {

						se ( tx.posicao_texto(PALAVRAS_PT[i], pal_pesquisada, 0 ) != -1) {
					
							gfx.desenhar_texto( 900, 165, PALAVRAS_CH[i])
						}
					}
					
				} senao {
					
					gfx.desenhar_texto( 780, 165, pal_pesquisada)

					para ( inteiro i = 0 ; i < 69 ; i ++ ) {

						se ( tx.posicao_texto(PALAVRAS_CH[i], pal_pesquisada, 0 ) != -1) {
					
							gfx.desenhar_texto( 300, 165, PALAVRAS_PT[i])
						}
					}
				}				
			}

			BARRA_DE_ROLAGEM( main_pos, c1_wl, pv_wl, pv_bar, pi_wl, lingua_padrao, palavra_barra_pesquisa, y)
			INTERATIVIDADE(teclado, lingua_padrao, CAPS_LOCK, y, palavra_barra_pesquisa, c1_wl, pal_pesquisada)

			FORMATACAO_TEXTO()
			gfx.definir_cor(gfx.criar_cor(0, 0, 0))
			gfx.desenhar_texto( 20, 15, palavra_barra_pesquisa)
			
			gfx.renderizar()

			
		}
	}

	funcao PARTE_ESTATICA(inteiro lingua_botao, logico teclado, logico CAPS_LOCK, inteiro lingua_padrao) {

		// BARRA_LISTA_DE_PALAVRAS() {

			// Fundo Branco Lista De Palavras
			gfx.definir_cor(gfx.criar_cor(255,255,255)) // Cor do fundo secundária onde ficará as palaras
			gfx.desenhar_retangulo(0, 0, 180, 720, falso, verdadeiro) // Desenhar o retângulo onde ficará as palavras
		
			// Fundo Escuro Lista De Palavras
			gfx.definir_cor(gfx.criar_cor(224,224,224)) // Cor do fundo secundária onde ficará as palaras
			gfx.desenhar_retangulo(15, 50, 150, 610, verdadeiro, verdadeiro) // Desenhar o retângulo onde ficará as palavras
		 	
		// }

		// BARRA_DE_PESQUISA() {

			// Barra De Pesquisa Fundo Azul
			gfx.definir_cor(gfx.criar_cor(0,171,255))
			gfx.desenhar_retangulo(16, 11, 145, 30, verdadeiro, verdadeiro)

			// Barra De Pesquisa Fundo Cinzento
			gfx.definir_cor(gfx.criar_cor(224,224,224))
			gfx.desenhar_retangulo(15, 10, 145, 30, verdadeiro, verdadeiro)

		// }

		// BOTAO_DE_TROCA_DE_LINGUA() {

			// Retangulo Cinzento Abaixo do Botão
			gfx.definir_opacidade(20)
			gfx.definir_cor(gfx.criar_cor(0,0,0))
			gfx.desenhar_retangulo( 20, 675, 100, 30, verdadeiro, verdadeiro) 

			// Retangulo Cinzento Acima do Botão
			gfx.definir_opacidade(20)
			gfx.definir_cor(gfx.criar_cor(0,0,0))
			gfx.desenhar_retangulo( 26, 681, 100, 30, verdadeiro, verdadeiro) 

			// Retangulo Branco Sobreposto - Botão
			gfx.definir_opacidade(255)
			gfx.definir_cor(gfx.criar_cor(255,255,255))
			gfx.desenhar_retangulo( 23, 678, 100, 30, verdadeiro, verdadeiro)
			
			gfx.definir_cor(gfx.criar_cor(0,171,255))
			gfx.definir_tamanho_texto(16.5)
			gfx.definir_fonte_texto("Arial Rounded MT Bold")
			gfx.desenhar_texto( 25, 684, upbotao[lingua_botao])

		// }

	
		// Retangulo Branco TRADUTOR
			gfx.definir_cor(gfx.criar_cor(255,255,255)) // Cor do fundo 
			gfx.desenhar_retangulo(210, 35, 1030, 640, verdadeiro, verdadeiro) // Desenhar o retângulo do fundo

		// REF Palavra Pesquisada	
			gfx.definir_cor(gfx.criar_cor(227, 227, 227)) // Cor do fundo 
			gfx.desenhar_retangulo(260, 150, 930, 50, verdadeiro, falso) // Desenhar o retângulo do fundo
			
			gfx.definir_cor(gfx.criar_cor(227, 227, 227)) // Cor do fundo Linha
			gfx.desenhar_linha(720, 150 , 720, 200) // Dsenhar Linha

		// REF Tradutor	
			gfx.definir_cor(gfx.criar_cor(227, 227, 227)) // Cor do fundo 
			gfx.desenhar_retangulo(260, 250, 930, 200, verdadeiro, falso) // Desenhar o retângulo do fundo
			
			gfx.definir_cor(gfx.criar_cor(227, 227, 227)) // Cor do fundo Linha
			gfx.desenhar_linha(720, 150 , 720, 200) // Dsenhar Linha
			

		// lINHA SEPARADORA, TITULO, LiNGUAS{

			// Fundo Cinzento 
			gfx.definir_cor(gfx.criar_cor(233, 233, 233))
			gfx.desenhar_retangulo(290, 20, 130, 30, verdadeiro, verdadeiro)

			// Palavra tradutor
			gfx.definir_cor(gfx.criar_cor(0, 171, 255 ))
			gfx.definir_tamanho_texto(17.5)
			gfx.desenhar_texto(300, 30, "TRADUTOR")

			se ( lingua_padrao == 0 ) {
				
				gfx.desenhar_texto(450, 110, "Português")

				gfx.desenhar_texto(900, 110, "Kwanhama")
				
			} senao {
				
				gfx.desenhar_texto(900, 110, "Português")

				gfx.desenhar_texto(450, 110, "Kwanhama")
			}	
		
		//}

		// IMAGENS {

			gfx.desenhar_imagem(700, 100, img_change)

		//}

		// SINALIZADOR_DO_TECLADO {

			BOTAO_DE_LINGUA ( teclado, CAPS_LOCK)
			
		//}
		
	}

	funcao FORMATACAO_TEXTO() {
		
		gfx.definir_estilo_texto(falso, verdadeiro, falso)
		gfx.definir_tamanho_texto(20.0)
		gfx.definir_cor(gfx.criar_cor( 0, 0, 0 ))
		gfx.definir_fonte_texto("Berlim Sans FB")
	}

	funcao LISTA_DE_PALAVRAS_NA_TELA(inteiro lingua_padrao, inteiro min, inteiro max, cadeia palavra_barra_pesquisa, inteiro y)
	{
		// Formatação do texto na barra de palavras
		FORMATACAO_TEXTO()
		
		logico correspondencia = falso
		
		se ( palavra_barra_pesquisa == "") {


			para ( inteiro i = min ; i < max ; i ++ ) {
							
				se ( lingua_padrao == 0 ) {				
								
					gfx.desenhar_texto( 30, y = y + 24, PALAVRAS_PT[i])
					
				} senao {		

					gfx.desenhar_texto( 30, y = y + 24, PALAVRAS_CH[i])
				}
			}
		}

		senao {
			
			para ( inteiro i = 0 ; i < 69 ; i ++ ) {
				
				se ( lingua_padrao == 0 ) {				
					
					se ( tx.numero_caracteres(palavra_barra_pesquisa) <= tx.numero_caracteres(PALAVRAS_PT[i]) e tx.caixa_baixa(palavra_barra_pesquisa) == tx.caixa_baixa(tx.extrair_subtexto(PALAVRAS_PT[i], 0, tx.numero_caracteres(palavra_barra_pesquisa))) ) {
						
						gfx.desenhar_texto( 30, y = y + 24, PALAVRAS_PT[i])
						
						REFERENCIAIS[counter_Re] = i

						correspondencia = verdadeiro

						counter_Re ++
					}
					
				} senao {
				
					se ( tx.numero_caracteres(palavra_barra_pesquisa) <= tx.numero_caracteres(PALAVRAS_CH[i]) e tx.caixa_baixa(palavra_barra_pesquisa) == tx.caixa_baixa(tx.extrair_subtexto(PALAVRAS_CH[i], 0, tx.numero_caracteres(palavra_barra_pesquisa)))) {
						
						gfx.desenhar_texto( 30, y = y + 24, PALAVRAS_CH[i])

						REFERENCIAIS[counter_Re] = i

						counter_Re ++

						correspondencia = verdadeiro
					
					} 
				}
			}

			se ( correspondencia == falso  ) {
					
				gfx.definir_cor(gfx.criar_cor(0, 171, 255 ))
				gfx.definir_tamanho_texto(14.5)
				gfx.desenhar_texto( 30, 60, "           Sem")
				gfx.desenhar_texto( 30, 84, "Correspondência")

			}
		}
	}

	funcao INTERATIVIDADE( logico &teclado, inteiro &lingua_padrao, logico CAPS_LOCK, inteiro y, cadeia palavra_barra_pesquisa, inteiro c1_wl, cadeia &pal_pesquisada) {

		//<>
			
		// Barra de Pesquisa		
		se ( m.botao_pressionado(0) e mouse( 15, 10, 145, 30 ) ) {

			teclado = verdadeiro

			BOTAO_DE_LINGUA ( teclado, CAPS_LOCK)
				
			u.aguarde(150)
		}

		// Botao de troca de lingua na barra de palavras
		se (  m.botao_pressionado(0) e mouse( 23, 678, 100, 30 ) ) {

			se ( lingua_padrao == 1 ) {

				lingua_padrao = 0		
				
			} senao {

				lingua_padrao = 1
				
			} u.aguarde(150)
		}

		// Pesquisa de Palavras
		se ( palavra_barra_pesquisa == "" ) {

			para ( inteiro i = 0 ; i < 25 ; i ++ ) {

				se ( mouse (15, y = y + 24, 150, 25) e m.botao_pressionado(0) ) {
	
					se ( lingua_padrao == 0 ) {
						
						pal_pesquisada = PALAVRAS_PT[c1_wl+i]	

						u.aguarde(150)
																	
					} senao {

						pal_pesquisada = PALAVRAS_CH[c1_wl+i]

						u.aguarde(150)
						
					} pare
					
				} 
			}
		
		} senao {

			para ( inteiro i = 0 ; i < counter_Re ; i ++ ) {
				
				se ( mouse (15, y = y + 24, 150, 25) e m.botao_pressionado(0) ) {
	
					se ( lingua_padrao == 0 ) {
						
						pal_pesquisada = PALAVRAS_PT[c1_wl+i]

						u.aguarde(150)
																	
					} senao {

						pal_pesquisada = PALAVRAS_CH[c1_wl+i]

						u.aguarde(150)
						
					} pare
				}

				
			} counter_Re = 0
		}

		// Reinicialização do programa
		se ( mouse (290, 20, 130, 30) e m.botao_pressionado(0) ) {

			inicio()
		}
	}

	funcao BOTAO_DE_LINGUA ( logico teclado, logico CAPS_LOCK) {

		//<>
		// Barra De Pesquisa Fundo Azul
			se ( CAPS_LOCK ) {
				
				gfx.definir_cor(gfx.criar_cor( 252, 166, 5 ))
				
			} senao se ( teclado ) {
				
				gfx.definir_cor(gfx.criar_cor( 0, 171, 255 ))
				
			} senao {
				
				gfx.definir_cor(gfx.criar_cor( 224, 224,224 ))
			}
			
			gfx.desenhar_retangulo(135, 678, 30, 30, verdadeiro, verdadeiro)
			gfx.definir_cor(gfx.criar_cor(255,255,255))
			gfx.definir_estilo_texto(falso, verdadeiro, falso)
			gfx.definir_tamanho_texto(19.5)
			gfx.desenhar_texto(143, 685, "T")
	}

	funcao BARRA_DE_ROLAGEM( logico &main_pos, inteiro &c1_wl, inteiro &pv_wl, inteiro &pv_bar, inteiro pi_wl, inteiro lingua_padrao, cadeia palavra_barra_pesquisa, inteiro y)
	{			
		//<>
		
		se ( main_pos ) {
			
			gfx.definir_cor(gfx.criar_cor( 56, 211, 232 ) ) // Cor da barra de rolagem
			gfx.desenhar_retangulo(168, pv_bar, 8, 40, verdadeiro, verdadeiro ) // Desenhar a barra de Rolagem
			LISTA_DE_PALAVRAS_NA_TELA( lingua_padrao, c1_wl, pv_wl, palavra_barra_pesquisa, y )
			pi_wl = pv_bar

		} se ( mouse( 168, 60, 20, 550 ) e m.botao_pressionado(0)  ){

				gfx.definir_cor(gfx.criar_cor(56, 211, 232)) // Cor do fundo secundária onde ficará as palaras
				gfx.desenhar_retangulo(168, pv_bar = m.posicao_y(), 8, 40, verdadeiro, verdadeiro) // Desenhar o retângulo onde ficará as palavras
				
				se ( m.posicao_y() % 10 == 0 e m.posicao_y() > pi_wl e m.posicao_y() <= 550 e c1_wl <= 43 e pv_wl <= 68 ) {

					LISTA_DE_PALAVRAS_NA_TELA( lingua_padrao,  c1_wl = c1_wl + 1, pv_wl = pv_wl + 1, palavra_barra_pesquisa, y) 

					escreva("\nMouse +"+m.posicao_y()+"\nV1 + "+c1_wl+"\nV2 +"+pv_wl)
					
				} senao se ( m.posicao_y() % 10 == 0 e m.posicao_y() < pi_wl e  m.posicao_y() >= 60 e c1_wl > 0 e pv_wl > 25) {

					LISTA_DE_PALAVRAS_NA_TELA( lingua_padrao,  c1_wl = c1_wl - 1, pv_wl = pv_wl - 1, palavra_barra_pesquisa, y )

					escreva("\nMouse -"+m.posicao_y()+"\nV1 - "+c1_wl+"\nV2 -"+pv_wl)
					
				} main_pos = falso		
							 
		} main_pos = verdadeiro 		
	} 
	
	funcao TECLADO( logico &teclado, logico &CAPS_LOCK, cadeia &palavra_barra_pesquisa, inteiro max_caracteres, logico &tradutor, cadeia &pal_tradutor) {
		
		//<>
		
		inteiro tecla = tc.ler_tecla()

		se ( tecla >= 65 e tecla <= 90 e tx.numero_caracteres(palavra_barra_pesquisa) < max_caracteres ou tecla == 8 ou tecla == 10 ou tecla == 20 ou tecla == 27 ou tecla == 32) {

			se ( tecla >= 65 e tecla <= 90 ) {

				se ( CAPS_LOCK ) {

					palavra_barra_pesquisa = palavra_barra_pesquisa + tx.caixa_alta(tp.caracter_para_cadeia(tc.caracter_tecla(tecla)))
					
				} senao {

					palavra_barra_pesquisa = palavra_barra_pesquisa + tx.caixa_baixa(tp.caracter_para_cadeia(tc.caracter_tecla(tecla)))
				}
				
			} senao {
				
				escolha (tecla) {

				caso 8: // Tecla BackSpace - Apagar

					se ( tx.numero_caracteres(palavra_barra_pesquisa) > 0 ) {
						
						palavra_barra_pesquisa = tx.extrair_subtexto(palavra_barra_pesquisa, 0, tx.numero_caracteres(palavra_barra_pesquisa) - 1)
						
					} se (  tx.numero_caracteres(palavra_barra_pesquisa) == 0 ) {
						
						palavra_barra_pesquisa = ""
					}

				pare

				caso 10: // Tecla ENTER

				//Tradutor

				pare

				caso 20: // Caps Lock - Maiúsculas e Minúsculas

					 se ( CAPS_LOCK ) {

					 	CAPS_LOCK = falso
					 	
					 } senao {

					 	CAPS_LOCK = verdadeiro	
					 					 	
					 } BOTAO_DE_LINGUA ( teclado, CAPS_LOCK)

				pare

				caso 27: // Tecla Esc

					teclado = falso
					CAPS_LOCK = falso
					tradutor = falso

				pare

				caso 32: // Tecla Espaço

					palavra_barra_pesquisa = palavra_barra_pesquisa + " "

				pare
				
				}
			}			
		} 
	}

	funcao logico mouse ( inteiro x, inteiro y, inteiro x1, inteiro y1) {

		//<>
		
		se ( m.posicao_x() >= x e m.posicao_y() >= y e m.posicao_x() <= x + x1 e m.posicao_y() <= y + y1 ) {

			retorne verdadeiro
			
		} retorne falso
	}
}


/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5503; 
 * @DOBRAMENTO-CODIGO = [23, 81, 331, 339, 406, 490, 514, 547, 622];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {REFERENCIAIS, 21, 3, 12}-{y, 151, 4, 1}-{pal_pesquisada, 160, 4, 14};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
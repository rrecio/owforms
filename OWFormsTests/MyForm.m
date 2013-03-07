//
//  MyForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 10/05/12.
//  Copyright (c) 2012 Owera Software. All rights reserved.
//

#import "MyForm.h"

@interface MyForm ()

@end

@implementation MyForm

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self loadForm];
        [self loadData];
    }
    return self;
}

- (void)loadForm
{
    self.cellsBackgroundImage   = [UIImage imageNamed:@"cell_bg"];
    
    for (int i = 0; i < 10; i++) {
        OWSection *primeiraSecao    = [OWSection section];
        primeiraSecao.headerTitle   = @"Aplicativo";
        
        OWFieldText *nomeField      = [OWFieldText fieldWithLabel:@"Nome"];
        nomeField.textLabelColor    = [UIColor greenColor];
        nomeField.detailLabelColor  = [UIColor yellowColor];
        nomeField.backgroundImage   = [UIImage imageNamed:@"blue_cell_bg"];
        
        OWFieldNotes *descricao     = [OWFieldNotes fieldWithLabel:@"Descrição"];
        OWFieldNumber *buildNumber  = [OWFieldNumber fieldWithLabel:@"Número do build"];
        OWFieldDate *dataLancamento = [OWFieldDate fieldWithLabel:@"Data de Lançamento"];
        
        primeiraSecao.fields = [@[nomeField, descricao, buildNumber, dataLancamento] mutableCopy];
        
        [self addSection:primeiraSecao];
    }
}

- (void)loadData
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"BabyNotes", @"Nome", 
                                     @"Uma forma bonita e elegante de os pais tomarem nota do crescimento de seus filhos, visualizando os dados cadastrados como úteis gráficos informativos. Inclui controle de peso, altura, circunferência cefálica, alimentação e registros médicos como consultas, exames e vacinas.", @"Descrição", 
                                     [NSNumber numberWithInt:123], @"Número do build", nil];
    [self addDataFromDictionary:dataDict];
}

- (BOOL)callActionControllerForField:(OWField *)field selectedAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end

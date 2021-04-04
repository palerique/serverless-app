import { APIGatewayProxyHandler } from 'aws-lambda';

interface Hero {
  id: string;
  name: string;
}

function getData(): { heroes: Hero[] } {
  const heroes: Hero[] = [
    { id: '11', name: 'Dr Nice' },
    { id: '12', name: 'Narco' },
    { id: '13', name: 'Bombasto' },
    { id: '14', name: 'Celeritas' },
    { id: '15', name: 'Magneta' },
    { id: '16', name: 'RubberMan' },
    { id: '17', name: 'Dynama' },
    { id: '18', name: 'Dr IQ' },
    { id: '19', name: 'Magma' },
    { id: '20', name: 'Tornado' },
  ];
  return { heroes };
}

export const handler: APIGatewayProxyHandler = async (event, context) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ data: getData(), event, context }, null, 2),
  };
};

import { APIGatewayProxyHandler, APIGatewayProxyResult } from 'aws-lambda';
import { DynamoDB } from 'aws-sdk';
import { ScanInput } from 'aws-sdk/clients/dynamodb';

const dynamoDb = new DynamoDB.DocumentClient();
const params: ScanInput = {
  TableName: process.env.DYNAMODB_TABLE || 'Heroes',
};

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
  let result: APIGatewayProxyResult;

  // fetch all todos from the database
  // For production workloads you should design your tables and indexes so that your applications can use Query instead of Scan.
  await dynamoDb.scan(params, (error, queryResult) => {
    // handle potential errors
    if (error) {
      console.error(error);
      result = {
        statusCode: error.statusCode || 501,
        headers: { 'Content-Type': 'text/plain' },
        body: "Couldn't fetch the todo items.",
      };
    } else {
      result = {
        statusCode: 200,
        body: JSON.stringify({ result: queryResult, data: getData(), event, context }, null, 2),
      };
    }
  });

  // TODO: fix it
  return result;
};
